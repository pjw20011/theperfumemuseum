<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>향수 용어사전</title>
    <link rel="stylesheet" href="css/dictionary.css">
    <style>
        
    </style>
    <script defer src="js/dictionary.js"></script>
</head>
<body>
    <header>
        <%@ include file="header.jsp" %>
    </header>
    <div class="glossary-container">
        <section class="glossary-section">
            <div class="notion">
                <div>
                	<h2>향의 노트</h2>
                </div>
                <a href="notes.jsp" id="goto-notes">향수 노트 보러가기</a>
                <ul>
               		<li><p><strong>톱 노트</strong>
               		<br>첫인상을 결정짓는 향으로 뿌린 직후 느껴지는 향입니다. 주로 레몬, 베르가모트 등의 시트러스 계열이 이에 속합니다.</p></li>
               		<li><p><strong>미들 노트</strong>
                	<br>하트 노트라고도 불리며, 향의 중간 단계로 향수의 주제, 캐릭터가 잘 나타납니다.</p></li>
                	<li><p><strong>베이스 노트</strong>
                	<br>바텀 노트 또는 라스트 노트로, 향수를 뿌린 후 2~3시간 뒤부터 느껴지는 잔향입니다. 우드, 머스크 등의 향료를 사용합니다.</p></li>        	                
                </ul>
            </div>
            <div class="image-box">
            	<div class="image-gradient">
           			
                	<img src="image/dic_img1.jpg" alt="노트 이미지">
                </div>
            </div>
        </section>
        <section class="glossary-section">
            <div class="notion">
                <div>
                    <h2>향수의 종류</h2>
                </div>
                <ul>
                    <li><p><strong>EDP (Eau de Parfum)</strong> - 향 원액이 10~18% 정도로, 4~5시간 정도 향이 지속됩니다.</p></li>
                    <li><p><strong>EDT (Eau de Toilette)</strong> - 향 원액이 5~12%로, 지속 시간은 3~4시간입니다.</p></li>
                    <li><p><strong>EDC (Eau de Cologne)</strong> - 향 원액이 3~7%로, 잔향이 1~2시간 정도 지속됩니다.</p></li>
                </ul>
            </div>
            <div class="image-box">
            	<div class="image-gradient">
                	<img src="image/dic_img2.jpg" alt="향수 종류 이미지">
                </div>
            </div>
        </section>
        <section class="glossary-section">
            <div class="notion">
                <div>
                    <h2>향수와 젠더</h2>
                </div>
                <ul>
                    <li><p><strong>Femme</strong> - 여성향수를 나타내는 용어로, Woman, Elle, Her 등과 통용됩니다.</p></li>
                    <li><p><strong>Homme</strong> - 남성향수를 나타내는 용어로, Man, Uomo, Him 등과 통용됩니다.</p></li>
                </ul>
            </div>
            <div class="image-box">
            	<div class="image-gradient">
                	<img src="image/dic_img3.jpg" alt="향수와 젠더 이미지">
               	</div>
            </div>
        </section>
        <section class="glossary-section">
            <div class="notion">
                <div>
                    <h2>향의 종류</h2>
                </div>
                <ul>
                    <li><p><strong>CITRUS</strong> - 오렌지, 레몬 등 새콤달콤한 특성을 지닌 과일의 향.</p></li>
                    <li><p><strong>FRUITY</strong> - 농익은 과일의 달콤한 향.</p></li>
                    <li><p><strong>GREEN</strong> - 풀, 잎, 줄기 등을 연상시키는 신선한 향.</p></li>
                    <li><p><strong>AROMATIC</strong> - 로즈메리, 라벤더 등 허브 계열을 표현한 향.</p></li>
                    <li><p><strong>LIGHT</strong> - 프레시, 시트러스, 그린과 같이 휘발성이 높은 향으로 지속 시간이 짧다.</p></li>
                    <li><p><strong>HEAVY</strong> - 무겁게 가라앉아 지속력이 높은 향.</p></li>
                    <li><p><strong>FLORAL</strong> - 달콤한 꽃향기.</p></li>
                    <li><p><strong>SMOKY</strong> - 그을린 듯한 향.</p></li>
                    <li><p><strong>INCENSE</strong> - 인센스 스틱을 태워서 나는 듯한 향.</p></li>
                    <li><p><strong>ORIENTAL</strong> - 동양적인 향으로 발삼, 레진, 스파이시, 우디, 애니멀 향 등을 표현.</p></li>
                    <li><p><strong>SPICY</strong> - 톡 쏘는 듯한 자극적이고 강한 향.</p></li>
                    <li><p><strong>ANIMALIC</strong> - 동물성 향료에서 유래한 것으로 희석하여 사용할 경우 따듯한 느낌을 준다.</p></li>
                    <li><p><strong>LEATHER</strong> - 가죽 특유의 향.</p></li>
                    <li><p><strong>EARTHY</strong> - 흙, 산림 등 대지에서 비롯된 향.</p></li>
                    <li><p><strong>MUSK</strong> - 사향노루에서 추출한 향으로 따듯하고 포근한 느낌의 관능적인 향.</p></li>
                    <li><p><strong>DRY</strong> - 마른 나무, 이끼, 건초에서 느껴지는 건조한 향.</p></li>
                    <li><p><strong>ABSOLUTE</strong> - 식물에서 추출한 천연 향료.</p></li>
                    <li><p><strong>CHYPRE</strong> - 시원한 식물 향.</p></li>
                    <li><p><strong>WATERY</strong> - 물에서 느껴지는 상쾌하고 투명한 향.</p></li>
                    <li><p><strong>MARINE</strong> - 시원한 물과 해초류에서 느껴지는 짭조름한 느낌을 표현한 향.</p></li>
                    <li><p><strong>RESINOID</strong> - 송진, 식물 등에서 추출해 담은 향.</p></li>
                    <li><p><strong>BOUQUET</strong> - 다채로운 꽃이 혼합된 꽃다발에서 느껴지는 향.</p></li>
                    <li><p><strong>CHORD</strong> - 화음이라는 뜻으로 개별적인 향을 섞어 탄생한 새로운 형태의 향.</p></li>
                    <li><p><strong>BITTER</strong> - 나무뿌리, 약초, 애니멀 노트 등 서로 다른 성격의 여러 향이 복합되어 만들어낸 향.</p></li>
                    <li><p><strong>NUANCE</strong> - 향의 이미지를 연상시키는 향.</p></li>
                    <li><p><strong>HARMONY</strong> - 여러 향을 조합해 탄생한 새로운 향.</p></li>
                    <li><p><strong>TRAIL</strong> - 향수를 뿌린 후 지속되는 향의 여운, 잔향.</p></li>
                    <li><p><strong>WOODY</strong> - 나무에서 추출한 따뜻하고 자연적인 향.</p></li>
                </ul>
            </div>
            <div class="image-box">
            	<div class="image-gradient">
                	<img src="image/dic_img4.jpg" alt="향의 종류 이미지">
               	</div>
            </div>
        </section>
        <section class="glossary-section" id="last-section">
            <div class="notion">
                <div>
                    <h2>분리배출 방법</h2>
                </div>
                <ul>
                    <li><p>용기 내부의 남은 향수는 키친타월이나 신문지에 흡수시켜 버린다. 화학물질인 향수를 물로 흘려보내면 수질, 토양 오염을 유발할 수 있다.</p></li>
                    <li><p>용기에 부착된 라벨 스티커는 떼어내, 유리로 분리배출한다.</p></li>
                    <li><p>뚜껑, 스프링, 튜브도 소재별로 분리해 버린다.</p></li>
                    <li><p>만약 분리가 어렵다면 모두 일반쓰레기로 버려야 한다.</p></li>
                </ul>
            </div>
            <div class="image-box">
            	<div class="image-gradient">
                	<img src="image/dic_img5.jpg" alt="분리배출 방법 이미지">
               	</div>
            </div>
        </section>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>
