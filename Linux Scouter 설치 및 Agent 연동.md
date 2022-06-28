# Linux Scouter 설치 및 Agent 연동

---

Scouter는 LG CNS에서 개발 및 배포한 무료 APN이다.

이 툴을 통해 WAS의 성능 모니터링이 가능하다.
(heap memory, session 수, SQL 조회 등)

크게 **세 가지의 프로그램 설치**가 필요하다.

- **Agent :** 
WAS가 설치된 서버에 설치하며, 실시간 서비스 성능 정보, Heap Memory, Thread 등 Java 성능을 조사하여 정보를 획득함
- **Server** (Collector): 
WAS가 설치된 서버에 설치하며, Agent가 전송한 데이터 수집/처리
- **Client** (Viewer): 
수집된 성능 정보를 확인하기 위한 Client 프로그램

## **다운로드 및 설치**

---

- Scouter 파일 다운로드([https://github.com/scouter-project/scouter/releases)](https://github.com/scouter-project/scouter/releases)) v0.5.1 release
- scouter.agent.tar.gz
- scouter.server.tar.gz
- scouter.client.product-win32.win32.x86.zip

## Scouter Server 설치

---

![Untitled](https://user-images.githubusercontent.com/84123877/176130670-2bf9b648-d118-46ea-89d1-2fd8da4bda95.png)

```bash
$ wget https://github.com/scouter-project/scouter/releases/download/v2.8.1/scouter-all-2.8.1.tar.gz
```

wget에 없다면 설치하여 진행한다.

해당 tar.gz 파일을 가져왔다.

```
$ tar xvfz scouter-all-2.8.1.tar.gz
```

받은 파일의 압축을 해제한다. scouter라는 디렉터리가 생성된다.

![Untitled 1](https://user-images.githubusercontent.com/84123877/176130672-53329627-15ca-4959-bdc7-024f8fb25ab8.png)

> scouter 디렉터리에는 이와 같은 디렉터리들이 존재한다. 
이 상태에서 즉시 실행이 가능하다.
> 

```
$ cd /scouter설치경로/server
$ ./startup.sh
```

![Untitled 2](https://user-images.githubusercontent.com/84123877/176130676-420f9ab3-4309-40a7-98fe-00ebd851e27c.png)

> 해당 문구가 나타나면서 구동되는것을 확인 가능하다.
> 

```
vi /scouter설치경로/server/conf/scouter.conf
```

Scouter Server에서 사용하는 network port, log 등의 정보는 해당 파일에서 변경할 수 있다.

vi 명령어로 확인하면 처음에는 아무값도 들어있지 않다.

## Client (Viewer) 실행

---

Scouter는 웹에서 보는 것이 아닌 전용 툴을 설치하여 모니터링을 진행한다.

전용 툴을 받기 위해 깃허브에서 원하는 OS 버전의 압축파일은 받는다.

[Release v2.8.1 · scouter-project/scouter](https://github.com/scouter-project/scouter/releases/tag/v2.8.1)

![Untitled 3](https://user-images.githubusercontent.com/84123877/176130680-eb92fcb5-7a6f-485d-b8e2-f0303a3a943e.png)

![Untitled 4](https://user-images.githubusercontent.com/84123877/176130685-113feabc-1f28-44c5-bbc4-ddd336e7e6d9.png)

> 다운받은 압축파일을 해제하고 scouter 파일을 실행시킨다.
> 

![Untitled 5](https://user-images.githubusercontent.com/84123877/176130687-8745d7b1-e672-4c2a-a1d0-2bec907bd752.png)

> Server Address는 위에서 Scouter를 설치한 server의 ip를 입력하고,
id/passwd는 admin/admin 이 초기값이다. (해당 서버의 유저인줄알고 좀 헤맸다…)
> 

![Untitled 6](https://user-images.githubusercontent.com/84123877/176130689-3423f493-22a3-4a5f-8c4f-c66dc270da9e.png)

> 로그인 성공시 해당 화면이 나타난다.
> 

---

## Host Agent 실행

---

Host Agent는 OS의 CPU, memory, disk 사용량 등의 정보를 파악할 수 있게 해준다.

즉, OS 당 하나씩만 설정을 해주면 된다.

일단 Scouter agent 파일은 Client (Viewer) 를 다운받을때 경로로 들어가면 
Scouter-min-2.8.1.tar.gz 파일이 존재한다.

해당 파일을 받아 모니터링할 서버에 적당한 위치에 옮겨서 풀어준다.

![Untitled 7](https://user-images.githubusercontent.com/84123877/176130691-39d7dfb1-5fa4-4537-9275-d0909ccaff7f.png)

```
vi /scouter설치경로/agent.host/conf/scouter.conf
```

해당 경로에서 Scouter Srver의 정보를 기입한다.

주석 처리가 되어있는 부분은 풀고 입력하면 된다.

![Untitled 8](https://user-images.githubusercontent.com/84123877/176130696-148c619a-d4f3-46a6-a590-80d58ba37ff6.png)

해당 설정으로 agent와 Scouter server가 연동이 되었다면 Client에서도 Configure를 통해 간단하게 수정이 가능하다.

![Untitled 9](https://user-images.githubusercontent.com/84123877/176130655-f61cee6d-19ae-4869-8220-9e22a81b0d92.png)

> 모두 기입한뒤, 실행을 진행한다.
> 

```
$ cd /scouter설치경로/agent.host$ ./host.sh
```

해당 명령어로 간단히 실행 가능하다.

![Untitled 10](https://user-images.githubusercontent.com/84123877/176130662-b585cf79-40d8-4306-8b7d-0ed64016eddf.png)

> 실행을 진행하고 Client(Viewer)로 돌아가보면 Scouter server에 팽귄이 연결된것을 볼 수 있다.
(펭귄은 리눅스 서버라는 뜻이다.)
> 

---

## Java Agent 실행

---

Java Agent는 Heap Memory, Thread 등의 Java Application의 성능 정보를 파악할 수 있게 해준다.

tomcat 위에서 기동할 application을 모니터링 하기 위해 scouter agent를 설치하고 설정하겠다.
scouter 디렉터리에 agent.java 디렉터리가 존재하는데 이곳에서 설정을 진행한다.

![Untitled 11](https://user-images.githubusercontent.com/84123877/176130664-4ca2b030-1bad-4b94-a7a7-dc211389a7e5.png)

> 마찬가지로 conf 디렉터리에 scouter.conf 파일에서 연결해주는 작업을 설정한다.
instance가 여러개라면 scouter.conf 파일도 여러개를 작성하여야 한다. 
(scouter1.conf, scouter2.conf …)
> 

```
JAVA_OPTS=" ${JAVA_OPTS} -javaagent:${SCOUTER_AGENT_DIR}/scouter.agent.jar"
JAVA_OPTS=" ${JAVA_OPTS} -Dscouter.config=${SCOUTER_AGENT_DIR}/conf/scouter.conf"
JAVA_OPTS=" ${JAVA_OPTS} -Dobj_name=myFirstTomcat1"
```

agent conf 설정이 끝났다면 tomcat의 catalina.sh나 [startup.sh](http://startup.sh) 파일에서 scouter agent의 정보를 넣어준다.

이후 서버를 재기동한다.

![Untitled 12](https://user-images.githubusercontent.com/84123877/176130665-a7578b00-7a5f-46c5-9061-6133db14d86c.png)

![Untitled 13](https://user-images.githubusercontent.com/84123877/176130668-c379cc9a-2bb1-4b9e-8b46-984e94a59aec.png)

> 잘 연결 되었다면 부팅 로그 확인 가능하며, Clinet에 tomcat을 상징하는 고양이가 나타난것을 확인 가능하다.
> 

---
