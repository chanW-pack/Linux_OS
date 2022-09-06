# LVM 용량 추가 및 축소

---

## 실습 배경

---

동일한 VG를 사용하는 LVM 2개가 있다. LVM1, LVM2라고 설명하겠다.
LVM1의 용량을 축소하고,축소한 만큼의 용량을 다른 LVM, 즉 VLM2에 이어 붙여 용량을 증설하는 실습을 진행하고자 한다.

대부분 LVM 실습에서 ext.4 파일시스템으로 진행하였으나, 이번 실습은 xfs 파일시스템으로 진행하였다.

ext.4는 LVM 증설 및 축소에 문제없이 동작하지만, xfs는 lvm 축소를 지원하지 않으며, 그래도 축소를 진행하게 되면 lvm 내의 데이터들이 손상되게 된다.

하지만 xfs lvm이라도 축소를 어쩔수없이 해야하는 상황이 오게된다면, 을 바탕으로 실습을 진행하였다.

축소가 불가하기에 기존 lvm 파일시스템을 image로 저장하여 데이터를 백업한뒤, 

lvm 축소를 진행하는데, xfs lvm을 축소하게되면 파일시스템이 손상되어 풀리게된다. 

즉, 파일시스템을 xfs로 재설정한다

이후 재 mount 후 , 백업한 image를 복원하는 방법으로 진행하겠다..

## LVM 생성

---

AWS EC2를 생성하여 실습을 진행하겠다.

![Untitled](https://user-images.githubusercontent.com/84123877/177227020-c797c12d-7ff5-437a-88de-24bbaddccbc2.png)

> AWS EC2에 100GB, 20GB의 볼륨 2개를 추가하였다.
> 

![Untitled 1](https://user-images.githubusercontent.com/84123877/177226988-1e4b7004-87d1-4128-a32b-d2fd03e0df31.png)

> 두 볼륨 타입을 LVM으로 설정하였다
> 

\\<!-- ![Untitled 2](https://user-images.githubusercontent.com/84123877/177226992-f70a8c73-7305-4a21-a612-4e7aa03a0f81.png) -->

> **LVM 생성은 생략한다**. (그런데 그냥 100G LVM1을  실습하였으므로… LVM2는 신경쓰지 않아도 상관 무~)
> 

혹시 TMI를 원한다면 <링크>

![Untitled 3](https://user-images.githubusercontent.com/84123877/177226993-f4a69c12-45c9-4594-b65a-5922512ba137.png)

> cwtest VG에서 100GB를 나눠 가진 lvmdata_1(70G), lvmdata_2(30G) 를 생성했다.
> 

## LVM 용량 축소 및 데이터 복구 (xfs 한정)

---

![Untitled 4](https://user-images.githubusercontent.com/84123877/177226995-af7c9da8-f5b3-4cc2-afab-9e8cf5a510fd.png)

> lvmdata_1에 데이터를 추가했다. (testlvmFile1.txt)
> 

![Untitled 5](https://user-images.githubusercontent.com/84123877/177226997-c37b282b-3b15-44a0-9c98-ad4ab5565aa6.png)

> xfsdump 패키지를 설치한다.
> 

xfs의 축소 시 데이터 증발을 의식해서인지 xfs 전용 데이터 복구 패키지가 이미 존재한다.

해당 패키지로 lvm 내 데이터를 image화 시키면, lvm 축소 작업 도중 데이터가 손상되는 일이 발생하여도 안심이다^^

![Untitled 6](https://user-images.githubusercontent.com/84123877/177226998-de139cd4-7a11-4061-88ef-ec33abd4ca18.png)

> xfsdump 명령어로 데이터를 image화 시켰다.
> 

(해당 이미지를 생성할때 session 기록이 가능함. ex: 날짜)

![Untitled 7](https://user-images.githubusercontent.com/84123877/177226999-69d29571-23e7-41aa-9f10-4958c2f3263a.png)

> image로 문제없이 저장 완료
> 

![Untitled 8](https://user-images.githubusercontent.com/84123877/177227001-5ac1b77c-c90b-469a-8c3d-31199884d39f.png)

> 이제 lvm 용량 축소 작업을 위해 umount를 진행한다.
> 

축소 작업은 오프라인으로 진행해야하기 때문에 umount 이후 진행한다.

![Untitled 9](https://user-images.githubusercontent.com/84123877/177227005-8c40b94d-8920-4c62-87fb-9bb9195fe72a.png)

> umount 진행하니 파일시스템이 확인되지 않는다. (xfs 한정)
> 

![Untitled 10](https://user-images.githubusercontent.com/84123877/177227007-011bc8a3-e782-4968-82db-d62721902daf.png)

> mkfs 명령어로 파일시스템을 재설정한다. -f 옵션으로 강제설정
> 

![Untitled 11](https://user-images.githubusercontent.com/84123877/177227009-30263127-4765-4f7b-a679-a29484289692.png)

> 재설정하니 파일시스템이 잘 확인된다.
> 

![Untitled 12](https://user-images.githubusercontent.com/84123877/177227011-063791f0-0177-4a9b-b7cc-f7ed777b42ae.png)

> lvmdata_1 기존 용량에서 20GB가 줄어 50GB가 된 모습
> 

![Untitled 13](https://user-images.githubusercontent.com/84123877/177227013-6aa165f1-daee-4b39-b47e-104b806632eb.png)

> 축소는 성공적으로 완료했으나, 역시 파일은 손상되었다. (사라짐…)
> 

![Untitled 14](https://user-images.githubusercontent.com/84123877/177227014-01f2ef02-3107-4f56-8a91-651034c45f8d.png)

> xfsrestore 명령어로 기존 백업한 image를 불러와 백업을 진행시킨다.
> 

![Untitled 15](https://user-images.githubusercontent.com/84123877/177227015-6214e418-0526-48af-8a28-8b94e9a1c398.png)

> 복구가 완료되었다.
> 

그래도 혹시 모르니 따로 백업을 해두는것을 추천 (본인은 그렇게함)

## LVM 용량 추가

---

lvmdata_1의 축소는 정상완료하였고, 이젠 나머지 잉여용량을 lvmdata_2에 증설하겠다. 

![Untitled 16](https://user-images.githubusercontent.com/84123877/177227016-3c3e7ee5-4bd9-4fa3-80eb-b4897d3136ed.png)

> 증설은 축소와 다르게 온라인(살아있는) 에서도 진행되므로, umont 없이 바로 진행하였다.
> 

![Untitled 17](https://user-images.githubusercontent.com/84123877/177227017-616880aa-e956-4d1a-bfdf-5083011400d5.png)

> 증설은 완료되었는데 df -h 명령어로 확인해보면 아직 30GB로 적용이 안되어있는것을 확인할 수 있다.
> 

![Untitled 18](https://user-images.githubusercontent.com/84123877/177227018-e402bb01-d955-41b2-b370-416fc38b41ed.png)

> xfs_growfs 명령어로 용량 증설 내용을 적용 완료하였다.
> 

이렇게 lvm의 용량을 떼어내어 다른 lvm에게 증설시켜주는 내용을 진행하였고,
사실 ext.4 의 경우는 축소를 지원하기 때문에 xfs 를 진행한것처럼 복잡하게 패키지를 설치하는 등 작업이 적다.

같은 lvm 작업을 진행하더라도 파일시스템이 다르면 작업 내용도 완전히 달라진다는것이 이번 실습에 핵심 내용이리고 할 수 있다.

---
