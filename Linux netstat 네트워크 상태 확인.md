# Linux netstat 네트워크 상태 확인

---

### netstat

네트워크 연결상태, 라우팅 테이블, 인터페이스 상태등을 보여주는 명령어로, 네트워크 및 통계라는 단어에서 파생되었다.

### 사용법

```bash
netstat [옵션]
```

### 옵션

![Untitled](Linux%20netstat%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%89%E1%85%A1%E1%86%BC%E1%84%90%E1%85%A2%20%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB%2051d3dc8156b94dbfb2b2fe65f96dd30e/Untitled.png)

### 사용 예시

1. **모든 네트워크 연결 확인하기**
    
    ```bash
    netstat -a
    ```
    

![Untitled](Linux%20netstat%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%89%E1%85%A1%E1%86%BC%E1%84%90%E1%85%A2%20%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB%2051d3dc8156b94dbfb2b2fe65f96dd30e/Untitled%201.png)

> 모든 네트워크 연결상태를 보여준다. all 옵션과 동일하며 -a 옵션을 지정하지 않으면 Established 상태인 것만 나온다.
> 

1. **프로토콜 별로 출력하기**

```bash
netstat -at # TCP 만 확인
```

![Untitled](Linux%20netstat%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%89%E1%85%A1%E1%86%BC%E1%84%90%E1%85%A2%20%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB%2051d3dc8156b94dbfb2b2fe65f96dd30e/Untitled%202.png)

```bash
netstat -au # UDP 만 확인
```

![Untitled](Linux%20netstat%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%89%E1%85%A1%E1%86%BC%E1%84%90%E1%85%A2%20%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB%2051d3dc8156b94dbfb2b2fe65f96dd30e/Untitled%203.png)

1. LISTEN 상태인 포트만 출력하기
- 접속중인 상태 : ESTABLISHED
- 대기중인 상태 : LISTEN

```bash
netstat -nap | grep LISTEN
```

![Untitled](Linux%20netstat%20%E1%84%82%E1%85%A6%E1%84%90%E1%85%B3%E1%84%8B%E1%85%AF%E1%84%8F%E1%85%B3%20%E1%84%89%E1%85%A1%E1%86%BC%E1%84%90%E1%85%A2%20%E1%84%92%E1%85%AA%E1%86%A8%E1%84%8B%E1%85%B5%E1%86%AB%2051d3dc8156b94dbfb2b2fe65f96dd30e/Untitled%204.png)

---