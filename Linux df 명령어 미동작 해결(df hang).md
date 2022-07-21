# Linux df 명령어 미동작 해결(df hang)

---

![Untitled](https://user-images.githubusercontent.com/84123877/180142077-51f011e2-a602-473a-b367-1d8aca765cac.png)

- disk 용량 확인 하려고 df -h 명령어를 실행했는데 실행이 안되는 이슈가 있었다.

- 서버에 hang이 걸린줄 알고 시간을 두고 기다려도 계속 반응이 없다..

### 해결 방안

1. log 분석

![Untitled 1](https://user-images.githubusercontent.com/84123877/180142068-ec56b35a-af92-477e-8524-af3e6fd72287.png)

> 위 사진과 같이 /var/log/messages를 보면 nfs still trying 혹은 timed out 메세지가 나온 것을 볼수 있다.
> 
- 이럴 경우 server(nas) 네트워크 문제가 있다고 판단된다.
- client에서는 nfs로 mount 된 것을 물고 있지만 접근이 어려울 것이다.

![Untitled 2](https://user-images.githubusercontent.com/84123877/180142072-642df05e-bef8-422d-8aa6-2d59d995b308.png)

2. client 조치

![Untitled 3](https://user-images.githubusercontent.com/84123877/180142075-975340f4-0f91-41a7-8aa2-cc5b6d3627f5.png)

- 위 사진과 같이 공유 directory를 umount를 진행하였는데 **강제로 -f 옵션**까지 줘 봤는데도 device is busy 라는 문구가 나타난다.

![Untitled 4](https://user-images.githubusercontent.com/84123877/180142076-cf49148f-fdd6-4850-9864-98a9a9b744bb.png)

- -f 옵션까지 되지 않을 경우 **-l 옵션을 줘서 umount를 진행하여야 한다.
(본인은 -l 옵션으로 해결했다.)**

※ -l : 지연된 언마운트(lazy umount)

lazy umount는 디바이스가 사용되지 않을 때까지 대기한 후에 디렉토리 트리로부터 파일시스템을 umount한다.

(Detach the filesystem from the filesystem hierarchy now, and cleanup all references to the filesystem as soon as it is not busy anymore)

° 참고 : [https://linux.die.net/man/8/umount](https://linux.die.net/man/8/umount)

3. server(nas) 조치

- server에서는 nfs volume 확인 및 service restart 후에 client에서 다시 mount를 진행하면 된다.
- nfs를 사용할 경우 network가 안정적이여야 하는것이 매우 중요함.

---
