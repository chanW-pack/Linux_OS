# [Linux] Root 비밀번호 초기화

Rocky Linux로 Root 비밀번호 초기화 작업을 진행해보겠다.

1. 시스템 재부팅

![Untitled](https://user-images.githubusercontent.com/84123877/210200925-d326d5b8-b501-4678-a6de-c31a553a31b5.png)

시스템 재부팅을 통해 GRUB(응급모드,emergency mode) 화면에 진입한다.

GRUB에서 패스워드 초기화가 필요한 항목으로 이동 후 e키를 눌러 항목을 편집한다.

1. rd.break 모드에서 root 암호 복구

![Untitled 1](https://user-images.githubusercontent.com/84123877/210200918-5f46599a-cd2f-4a29-b1aa-c3e01cd1e6bd.png)

root 패스워드를 잃어 버렸을 경우 응급 모드로 진입해도 암호를 모르므로 복구가 불가능하다.

이 때, grub 부팅 옵션에 부팅 프로세스의 초기 단계만 수행(initramfs에서 실제 시스템으로 제어권을 넘기지 않고 부팅 종료) 하는 rd.break 옵션을 사용해야 한다.

rd.break 추가 후 ctrl-x 키를 눌러 부팅을 진행한다.

![Untitled 2](https://user-images.githubusercontent.com/84123877/210200920-4636a5c2-8417-4ece-9b0e-1b45c119c25d.png)

부팅되면 프롬프트가 *switch_root로 표시된다.

* switch_root : 마운트 트리 루트를 다른 파일시스템으로 전환하는 리눅스 명령어

다시 읽기 쓰기로 마운트하기 위해 mount -o rw,remount /sysroot 명령을 사용한다.

루트 파일 시스템을 변경하기 위해 chroot명령을 실행한다.

본인의 경우 이미 파일 시스템이 적용되어 있어 상관없다.

```bash
chroot /sysroot
```

* 루트 파일 시스템이 변경되면 프롬프트가 switch_root에서 sh-5.1로 변경된다.

![Untitled 3](https://user-images.githubusercontent.com/84123877/210200922-22118045-a16f-4a14-907c-b488d578d4a9.png)

이제 원래 리눅스 시스템에 반영되므로 passwd 명령을 실행하여 root 암호를 변경할 수 있다.

```bash
passwd root
```

![Untitled 4](https://user-images.githubusercontent.com/84123877/210200924-22081f71-8795-4b11-8e56-9b9e797d9893.png)

passwd 명령어로 루트 암호를 변경했다면 복구 모드에서 수정한 파일은 SElinux Context가 없어서 재부팅시 문제가 되어 로그인이 불가할 수 있다.

다음 명령을 사용하여 재부팅시 자동으로 파일에 대해 SELinux context relabeling을 수행한다.

```bash
touch /.autorelabel
or
fixfies onboot
```

- touch 명령을 파일명 오타를 내도 확인할 수 없으므로 fixfiles onboot 명령을 권장한다.

이후 exit를 입력하고 재부팅하여 암호 정상 변경 여부를 확인한다.

---
