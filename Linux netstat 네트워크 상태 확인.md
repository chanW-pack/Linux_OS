# Linux netstat 네트워크 상태 확인

---

### netstat

네트워크 연결상태, 라우팅 테이블, 인터페이스 상태등을 보여주는 명령어로, 네트워크 및 통계라는 단어에서 파생되었다.

### 사용법

```bash
netstat [옵션]
```

### 옵션

![Untitled](https://user-images.githubusercontent.com/84123877/180154870-2136372e-9e51-4505-8dde-8d46b33680ca.png)

### 사용 예시

1. **모든 네트워크 연결 확인하기**
    
    ```bash
    netstat -a
    ```
    

![Untitled 1](https://user-images.githubusercontent.com/84123877/180154857-0fee2d09-de71-439c-865b-0dc47ce5354b.png)

> 모든 네트워크 연결상태를 보여준다. all 옵션과 동일하며 -a 옵션을 지정하지 않으면 Established 상태인 것만 나온다.
> 

1. **프로토콜 별로 출력하기**

```bash
netstat -at # TCP 만 확인
```

![Untitled 2](https://user-images.githubusercontent.com/84123877/180154862-57d57e91-5311-4460-b042-16e7d8c29b89.png)

```bash
netstat -au # UDP 만 확인
```

![Untitled 3](https://user-images.githubusercontent.com/84123877/180154863-000cf4e3-60af-4d47-8e0f-97d436754fe2.png)

1. LISTEN 상태인 포트만 출력하기
- 접속중인 상태 : ESTABLISHED
- 대기중인 상태 : LISTEN

```bash
netstat -nap | grep LISTEN
```

![Untitled 4](https://user-images.githubusercontent.com/84123877/180154866-fd867f17-0d19-40b6-bc4a-abaa0fe88bb9.png)

---
