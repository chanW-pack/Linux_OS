# Linux df 명령어 미동작 해결(df hang)

---

![Untitled](Linux%20df%20%E1%84%86%E1%85%A7%E1%86%BC%E1%84%85%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%A5%20%E1%84%86%E1%85%B5%E1%84%83%E1%85%A9%E1%86%BC%E1%84%8C%E1%85%A1%E1%86%A8%20%E1%84%92%E1%85%A2%E1%84%80%E1%85%A7%E1%86%AF(df%20hang)%20c8ec65d18835496cbc0905a6a388a0d9/Untitled.png)

- disk 용량 확인 하려고 df -h 명령어를 실행했는데 실행이 안되는 이슈가 있었다.

- 서버에 hang이 걸린줄 알고 시간을 두고 기다려도 계속 반응이 없다..

### 해결 방안

1. log 분석

![Untitled](Linux%20df%20%E1%84%86%E1%85%A7%E1%86%BC%E1%84%85%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%A5%20%E1%84%86%E1%85%B5%E1%84%83%E1%85%A9%E1%86%BC%E1%84%8C%E1%85%A1%E1%86%A8%20%E1%84%92%E1%85%A2%E1%84%80%E1%85%A7%E1%86%AF(df%20hang)%20c8ec65d18835496cbc0905a6a388a0d9/Untitled%201.png)

> 위 사진과 같이 /var/log/messages를 보면 nfs still trying 혹은 timed out 메세지가 나온 것을 볼수 있다.
> 
- 이럴 경우 server(nas) 네트워크 문제가 있다고 판단된다.
- client에서는 nfs로 mount 된 것을 물고 있지만 접근이 어려울 것이다.

![Untitled](Linux%20df%20%E1%84%86%E1%85%A7%E1%86%BC%E1%84%85%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%A5%20%E1%84%86%E1%85%B5%E1%84%83%E1%85%A9%E1%86%BC%E1%84%8C%E1%85%A1%E1%86%A8%20%E1%84%92%E1%85%A2%E1%84%80%E1%85%A7%E1%86%AF(df%20hang)%20c8ec65d18835496cbc0905a6a388a0d9/Untitled%202.png)

2. client 조치

![Untitled](Linux%20df%20%E1%84%86%E1%85%A7%E1%86%BC%E1%84%85%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%A5%20%E1%84%86%E1%85%B5%E1%84%83%E1%85%A9%E1%86%BC%E1%84%8C%E1%85%A1%E1%86%A8%20%E1%84%92%E1%85%A2%E1%84%80%E1%85%A7%E1%86%AF(df%20hang)%20c8ec65d18835496cbc0905a6a388a0d9/Untitled%203.png)

- 위 사진과 같이 공유 directory를 umount를 진행하였는데 **강제로 -f 옵션**까지 줘 봤는데도 device is busy 라는 문구가 나타난다.

![Untitled](Linux%20df%20%E1%84%86%E1%85%A7%E1%86%BC%E1%84%85%E1%85%A7%E1%86%BC%E1%84%8B%E1%85%A5%20%E1%84%86%E1%85%B5%E1%84%83%E1%85%A9%E1%86%BC%E1%84%8C%E1%85%A1%E1%86%A8%20%E1%84%92%E1%85%A2%E1%84%80%E1%85%A7%E1%86%AF(df%20hang)%20c8ec65d18835496cbc0905a6a388a0d9/Untitled%204.png)

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