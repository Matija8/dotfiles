# https://stackoverflow.com/questions/2052390/manually-raising-throwing-an-exception-in-python

# ValueError is better than Exception!


def main():
    print('Main starting...')
    demo_bad_catch()
    try:
        demo_no_catch()
    except Exception:
        # print('ValueError except passed the error upward')
        pass
    print('Reached the end of main!')


def demo_bad_catch():
    try:
        raise ValueError('Represents a hidden bug, do not catch this')
        raise Exception('This is the exception you expect to handle')
    except Exception as error:
        print('Caught this error: ' + repr(error))


def demo_no_catch():
    try:
        raise Exception('general exceptions not caught by specific handling')
    except ValueError as e:
        print('we will not catch exception: Exception')


main()
