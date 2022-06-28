# Linux OTP

리눅스 서버의 운영체제에 접속하기 위해 대부분은 SSH(Secure Shell)을 사용한다. 하지만 서버가 인터넷에 노출되어 있는 경우 이렇게 SSH 서비스 접속을 허용하는 것은 꽤나 큰 위험이 된다.

이 때 가장 손쉽게 적용할 수 있는 것이 바로 개인정보보호법에서 요구하는 안전한 인증수단인 OTP이다.

그래서 이번 페이지에서는 리눅스 서버 운영체제에 안전한 인증수단인 OTP, 그 중에서도 Free하게 사용 가능한 구글 OTP를 적용하는과정을 학습하겠다.

## Ubuntu Linux에 구글 OTP 모듈 설치하기

![Untitled](https://user-images.githubusercontent.com/84123877/176129774-91b20306-138a-416b-b40e-69c1f61b3ff2.png)

> 다음과 같은 명령으로 우분투 리늑수에 구글 OTP의 서버모듈인 
Google Authenticator를 설치한다.
> 

당연히 Google Authenticator은 root 계정의 권한으로 설치해야 한다.

---

## 구글 OTP를 사용하여 접속할 계정에서 Google Authenticator 설정

이 단계를 진행하기 이전에 반드시 **스마트폰에 Google OTP 앱을 설치**하여야 한다.

Google OTP는 타임베이스의 1회용 비밀번호를 스마트폰에 설치한 Google OTP앱과 서버에 로그인할 때 서버에 설치된 Google Authenticator가 동시에 만들어 서로 비교하는 방식으로 인증을 수행하게 된다.

즉, 1회용 비밀번호를 만들 때 서버와 스마트폰의 통신은 없다.

다만 1회용 비밀번호를 만들 때 스마트폰과 서버가 서로 동일한 시크릿키(Secret Key)를 기준으로 만들어 보안을 유지하게 된다.

그래서 서버의 Google Authenticator 를 설치할 때 가장 중요한 것이 바로 이 시크릿 키를 스마트폰의 구글 OTP앱과 서버가 나누어 공유하는 과정이다.

<aside>
💡 구글에서는 이 시크릿 키를 사용자 계정마다 만드는데 “서버의 구글 OTP를 사용할 사용자 계정에서 Google Authenticator 초기화” 를 수행하고 이 때 QR 코드를 사용해 스마트폰의 구글 OTP 앱에 시크릿키를 공유하는 방법을 사용한다.

</aside>

---

## OS 계정에 Google Authenticator 설정하기

![Untitled 1](https://user-images.githubusercontent.com/84123877/176129777-80563502-fcdf-4b80-a9c7-0ee60f1cc42f.png)

![Untitled 2](https://user-images.githubusercontent.com/84123877/176129782-13616bb2-e0bd-4385-b2aa-d1e7a020ab68.png)

> 다음과 같이 구글 OTP를 사용해 2차 인증을 적용할 계정으로 로그인하여 설정한다.
> 

아래 사진을 보면 Secrekey와 이 시크릿 키 분실 시 복구할 수 있는 스크래치 코드를 보여준다.

최소한 스크래치 코드는 잘 보관하길 바란다.

그리고 중간에 실제 QR 코드가 큼지막하게 나온다. 이 **QR 코드를 구글 OTP 앱을 실행해 + 표시를 터치해 등록**해 준다. 그러면 구글 OTP에 해당 서버가 제목으로 되어 있는 1회용 비밀번호가 바로 표시되기 시작한다.

---

## 서버의 PAM 파일과 SSHD 설정 변경하기

로그인 과정에서 구글 OTP 인증과정을 실행시키기 위해 다음과 같이 PAM 설정 파일 중 sshd 파일에 설정 문구를 추가한다.

![Untitled 3](https://user-images.githubusercontent.com/84123877/176129783-d141d7b7-b1ba-428f-8b9e-d45e4fcd8278.png)

> 이 파일은 /etc/pam.d 디렉토리 sshd 라는 이름으로 위치해 있다.
> 

다음은 /etc/ssh/sshd_config 파일을 수정한다. 이 파일의 위치는 설치 방법에 따라, 운영체제 버전에 따라 조금 다를 수 있다. 

다음의 4개의 옵션을 찾아 아래와 같이 수정한다.

- UsePAM yes
- ChallengeResponseAuthentication yes

Google OTP는 사실 Challenge-Response 방식의 인증은 아니지만 sshd가 운영체제 인증에 추가해 적용되는 2차 비밀번호를 입력받기 위해 ChallengeResponseAuthentication 옵션을 yes 로 변경해야 하는 것으로 보인다.

그리고 두 옵션 외에 하나를 더 변경하라고 하는 경우가 있는데... 본인은 두 옵션만 변경하면 다른 옵션을 건드리지 않아도 문제 없이 동작하였다.

그리고 나서 sshd 서비스를 재구동 한다.

![Untitled 4](https://user-images.githubusercontent.com/84123877/176129786-e2bd5833-06bc-4787-bb25-c4e49dac4768.png)

---

## 구글 OTP로 로그인하기

해당 서버에 ssh 접속을 시도하고 Google Authenticator를 설정한 계정의 ID를 입력한다.

![Untitled 5](https://user-images.githubusercontent.com/84123877/176129790-d931e813-17a8-448b-87bd-168e83ee926c.png)

> 계정을 입력하고 비밀번호를 입력하니 OTP 비밀번호 6자리를 묻는다.
> 

![Untitled 6](https://user-images.githubusercontent.com/84123877/176129794-91686796-536e-45f7-8cfb-fc5b7541244b.png)

> 로그인이 성공적으로 진행되었다.
> 

---
