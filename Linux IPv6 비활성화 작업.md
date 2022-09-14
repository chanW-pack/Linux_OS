# Linux IPv6 비활성화 작업

---

오늘 전 서버의 IPv6 비활성화하는 작업을 진행하였는데, 진행이 더디었던 부분과 해결된 부분까지 작성해보겠다.

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled.png)

> 예시로 생성한 서버이다.
> 

서버를 체크해보면 IPv6로 올라온 포트들이 나타난다. (IPv6 = tcp6)

(보통 tcp6으로 올라오는 포트는 죽이고 다시 데몬올 올리면 tcp4로 올라온다.)

제일 간단한 방법은 IPv6 사용을 disable 하는 것이다.

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled%201.png)

```bash
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
0
```

해당 파일을 열어보면, 0은 사용중 1은 사용 안함으로 나타난다.

(IPv6를 사용하지 않느냐 → 1(참) 으로 이해하면 된다.)

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled%202.png)

> ifconfg를 보면 inet6 주소가 보이는것을 확인할 수 있다.
> 

tcp6를 disalbe하기 위해 시스템 환경변수를 수정한다.

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled%203.png)

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled%204.png)

```bash
vi /etc/sysctl.conf

net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

sysctl -p
```

sysctl.conf 파일을 수정한다. 

이후 sysctl -p 명령으로 sysctl.conf 파일을 적용 완료한다.

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled%205.png)

> ipv6가 사라진것을 확인할 수 있다.
> 

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled%206.png)

> 하지만 22, 111 등 포트는 그대로 tcp6로 살아있는것을 확인할 수 있다.
> 

tcp6는 off되었지만 형식으로만 나타나는것인지는 잘 모르지만, 

고객은 아얘 tcp6의 형식인 포트까지도 없애기를 요청하여 진행하였다.

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled%207.png)

```bash
vi /etc/default/grub 

GRUB_CMDLINE_LINUX="ipv6.disable=1"

grub2-mkconfig -o /boot/grub2/grub.cfg // 수정 내용 적용
```

grob에 설정을 추가하여 서버를 부팅하면 적용된다.

![Untitled](Linux%20IPv6%20%E1%84%87%E1%85%B5%E1%84%92%E1%85%AA%E1%86%AF%E1%84%89%E1%85%A5%E1%86%BC%E1%84%92%E1%85%AA%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%8B%E1%85%A5%E1%86%B8%20116d87288d33434ea748d4b18e612214/Untitled%208.png)

> 위 방법을 말고도 netconfig를 수정하는 방법도 있다.
> 

IPv6는 아직은 사용 이유가 크게 없는듯해보인다. (전부 disalbe해달라는 금일 요청만 봐도..)

한국에서 IPv6는 아직 돼지목에 걸린 진주라는 말이 있을 정도로 클라이언트에서 들어올 일이 거의 없다고들 한다. 브라우저들도 이미 ipv6를 지원하지만 사업자들의 장비가 아직 제대로 지원하지 않는다.

하지만 ipv6 기술은 이미 완성되어가고 있고, 세계적으로 ipv6의 도입을 위한 활동이 활발하게 진행되고 있다. (일본과 유럽에서는 ipv6의 구체적인 사업 모델을 선정하여 기술 개발을 하고있다고 한다.)

따라서 앞으로는 ipv6 활용에 본격적으로 관심을 가져야 하지 않을까 하는 생각이 든다.