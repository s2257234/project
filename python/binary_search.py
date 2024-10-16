arr = []
target = 67
for i in range(1, 101):
    if i % 2  != 0:
        print(i)
        arr.append(i)

def search(arr, target):
    left = 0
    right= len(arr)-1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1
print([search(arr, target)])

