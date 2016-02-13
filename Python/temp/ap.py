import sys

if __name__ == "__main__":
       count = int(sys.stdin.readline().strip())
       ap_list = [int(i) for i in sys.stdin.readline().strip().split()]
       diff = (ap_list[-1] - ap_list[0])/count
       new_list = range(ap_list[0],ap_list[-1],diff)
       print list(set(new_list) - set(ap_list))[0]
