import subprocess

# Pattern1
print("===========")
print("subprocess start!")
a = subprocess.check_output(["ls"])
print(a.decode())
print("subprocess end")

# Pattern2 
print("===========")
print("subprocess start!")
a = subprocess.run(["ls"], stdout = subprocess.PIPE)
print(a.stdout.decode())
print("subprocess end")

# Pattern3
print("===========")
print("subprocess start!")
a = subprocess.getoutput(["ls"])
print(a)
print("subprocess end")
