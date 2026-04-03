# 그림 색칠하기 게임

## 프로젝트 설명
본 시스템은 Zynq SoC 기반의 하드웨어 가속 색칠 게임 플랫폼으로, PS(Processing System)와 PL(Programmable Logic) 간 AXI4-Lite 인터페이스를 통해 도형 출력, 색칠 상태 판단, 클리어 조건 판정 등을 하드웨어 레벨에서 처리합니다.

## 항목	설명
1. 이미지 표시: gstart.bin, gclear.bin 등은 SD 카드에서 읽은 후, PS가 Block Memory Generator로 preload하여 PL로 전달함
2. paint 상태 저장: 색칠 여부를 paint[] 배열로 관리, rgb 모듈 내부에서 도형 형태와 비교
3. 도형 출력: mode 값에 따라 사각형, 원, 포도 또는 자유 그림 모드의 형태를 출력
4. 완료 판정: paint[] 배열을 통해 모든 내부가 색칠되었는지 판단, done=1 발생
5. 출력 타이밍 제어: horizontal.v, vertical.v에서 DE, Hsync, Vsync 생성
6. 최종 RGB 출력: g2m.v에서 RGB565 데이터를 TFT LCD에 전송

## 구성 요소	설명
TextLCD - PS에서 AXI Lite로 제어, 로그인 및 상태 정보 출력
7-Segment - PS에서 직접 숫자 출력 제어 (점수/시간)
TFT LCD - PL에서 도형, 색칠 상태를 VGA 방식으로 직접 출력
Block Memory - PS에서 preload한 이미지(*.bin) 데이터를 PL에서 읽어 표시
GPIO (done) - 색칠 완료 신호를 AXI GPIO를 통해 PS로 전달
