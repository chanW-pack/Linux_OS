# RHCSA_CMD
---

RHCSA 시험 시 기본 순서

- server A  
네트워크 설정    
호스트네임 설정  
리포지토리 설정  
- server B  
root 비밀번호 초기화  
호스트네임 설정(확인)  
리포지토리 설정  

---
- [계정 생성](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%EA%B3%84%EC%A0%95%20%EC%83%9D%EC%84%B1.md)
- [SELINUX]
- [파일권한 설정](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%ED%8C%8C%EC%9D%BC%EA%B6%8C%ED%95%9C%20%EC%84%A4%EC%A0%95.md)
- [스케쥴링 설정](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%EC%8A%A4%EC%BC%80%EC%A5%B4%EB%A7%81%20%EC%84%A4%EC%A0%95.md)
- [협력디렉터리 생성](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%ED%98%91%EB%A0%A5%20%EC%9E%91%EC%97%85%20%EB%94%94%EB%A0%89%ED%86%A0%EB%A6%AC%20%EC%83%9D%EC%84%B1.md)
- [NTP 설정](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/NTP%20%EC%84%A4%EC%A0%95.md)
- [NFS](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/NFS.md)
- [autofs 설정]
- [사용자 계정 생성](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%EC%82%AC%EC%9A%A9%EC%9E%90%20%EA%B3%84%EC%A0%95%20%EC%83%9D%EC%84%B1.md)
- [파일 찾기](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%ED%8C%8C%EC%9D%BC%20%EC%B0%BE%EA%B8%B0.md)
- [find 표현식](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/find%20%ED%91%9C%ED%98%84%EC%8B%9D.md)
- [문자열 찾기](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%EB%AC%B8%EC%9E%90%EC%97%B4%EC%B0%BE%EA%B8%B0.md)
- [아카이브 생성](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%EC%95%84%EC%B9%B4%EC%9D%B4%EB%B8%8C%20%EC%83%9D%EC%84%B1.md)
- [기본권한 설정](https://github.com/chanW-pack/Linux_OS/blob/main/RHCSA_CMD/%EA%B8%B0%EB%B3%B8%EA%B6%8C%ED%95%9C%20%EC%84%A4%EC%A0%95.md)

디스크 문제를 풀기 전 알아야 할 사항

1. 현재 디스크의 구성이 어떻게 되어있는가를 확인한다.
![Untitled](https://user-images.githubusercontent.com/84123877/206657565-c6dafff1-cb7d-4614-8d9a-eea7e2a843fb.png)  
시험에서 사용하는 것은 vdb로 되어 있는 디스크를 사용한다.  
절대 기존에 있는 myvol-vo는 제거하면 안된다.  

문제는 다음과 같이 나올것으로 예상된다.  
- 논리볼륨 생성
- 논리볼륨 확장
- 스왑 파티션
- 또 한가지 디스크 구성 (vdc를 사용하기 때문에 번외)  

디스크의 용량을 확인해본다.
![Untitled 1](https://user-images.githubusercontent.com/84123877/206657559-b682d06e-3986-44ab-ba70-a49040e2c0a2.png)
```bash
전체용량은 4GB
현재 사용중인 용량은 511M

계산 > 내가 사용해야 하는 것

논리볼륨 증설 현재 182 > 250m 증설,
현재 사용된 용량 = 511m
즉, 추가로 파티션에서 진행할 것은 없다.

논리볼륨 생성 800m
스왑 512m
적어도 1300m가 되는가?? 된다..

다시 한번 말하지만 중요한 점
<< 기존의 vo를 절대 삭제하면 안된다 >>

** LVM 명령어가 설치되어 있지 않다면
yum install lvm2 -y
```
- [LV 사이즈 증설]
- [스왑 추가]
- [논리 볼륨 생성]
- [Stratis]
- [vdo]
- [시스템 성능 튜닝]
 
