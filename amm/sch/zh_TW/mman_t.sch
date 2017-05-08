/* 
================================================================================
檔案代號:mman_t
檔案名稱:會員卡種資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mman_t
(
mmanent       number(5)      ,/* 企業編號 */
mmanunit       varchar2(10)      ,/* 應用組織 */
mman001       varchar2(10)      ,/* 卡種編號 */
mman002       varchar2(10)      ,/* 版本 */
mman003       varchar2(1)      ,/* 外社卡 */
mman004       varchar2(10)      ,/* no use */
mman005       number(5,0)      ,/* 卡號總碼長 */
mman006       number(5,0)      ,/* 卡號固定編號長度 */
mman007       varchar2(30)      ,/* 卡號固定編號 */
mman008       number(5,0)      ,/* 卡號流水碼長度 */
mman009       varchar2(10)      ,/* 發卡方式 */
mman010       number(20,6)      ,/* 消費附贈最低消費金額 */
mman011       number(20,6)      ,/* 購卡金額 */
mman012       varchar2(40)      ,/* 發卡贈品商品編號 */
mman013       number(20,6)      ,/* 換卡工本費 */
mman014       number(20,6)      ,/* 補卡工本費 */
mman015       varchar2(1)      ,/* 卡記名 */
mman016       varchar2(1)      ,/* 使用時需開卡 */
mman017       varchar2(1)      ,/* 卡需設定密碼 */
mman018       varchar2(1)      ,/* 卡效期控管 */
mman019       varchar2(10)      ,/* 效期規則起算基準 */
mman020       varchar2(10)      ,/* 有效期至 */
mman021       date      ,/* 效期指定日期 */
mman022       number(5,0)      ,/* 效期指定月份長度 */
mman023       varchar2(1)      ,/* 卡效期延長 */
mman024       number(5,0)      ,/* 效期延長月份長度 */
mman025       number(5,0)      ,/* 效期延長次數 */
mman026       varchar2(1)      ,/* 會員折扣 */
mman027       varchar2(1)      ,/* 積點 */
mman028       varchar2(10)      ,/* 預設積點基準單位 */
mman029       number(5,0)      ,/* 預設積點基準 */
mman030       number(5,0)      ,/* 預設單位積點 */
mman031       varchar2(10)      ,/* 積點清零規則 */
mman032       number(5,0)      ,/* 積點月後清零 */
mman033       number(5,0)      ,/* 積點日後清零 */
mman034       number(5,0)      ,/* 積點指定清零日期-月 */
mman035       number(5,0)      ,/* 積點指定清零日期-日 */
mman036       varchar2(10)      ,/* 積點取位 */
mman037       varchar2(10)      ,/* 取位方法 */
mman038       varchar2(1)      ,/* 積點抵現 */
mman039       number(20,6)      ,/* 預設最低抵現消費額 */
mman040       number(20,6)      ,/* 預設抵現積點基準 */
mman041       number(20,6)      ,/* 預設抵現單位金額 */
mman042       varchar2(1)      ,/* 可儲值 */
mman043       varchar2(1)      ,/* 可重複儲值 */
mman044       number(20,6)      ,/* 每次儲值金額上限 */
mman045       number(20,6)      ,/* 每次儲值金額下限 */
mman046       number(20,6)      ,/* 最高總儲值金額 */
mman047       varchar2(1)      ,/* 儲值折扣 */
mman048       number(5,0)      ,/* 預設儲值折扣率 */
mman049       varchar2(1)      ,/* 儲值加值 */
mman050       number(20,6)      ,/* 預設加值最低金額條件 */
mman051       number(20,6)      ,/* 預設加值儲值金額基準 */
mman052       number(20,6)      ,/* 預設單位加值金額 */
mman053       varchar2(40)      ,/* 卡種對應商品編號 */
mman054       varchar2(40)      ,/* 儲值金額對應商品編號 */
mman055       number(5,0)      ,/* 預設抵現上限比例 */
mman056       number(20,6)      ,/* 預設抵現上限金額 */
mman057       varchar2(10)      ,/* 積點抵現對應款別編號 */
mman058       varchar2(10)      ,/* 儲值對應款別編號 */
mman059       varchar2(10)      ,/* 卡異動明細產生方式 */
mman060       varchar2(40)      ,/* 積分對應商品編號 */
mmanstus       varchar2(10)      ,/* 狀態碼 */
mmanownid       varchar2(20)      ,/* 資料所有者 */
mmanowndp       varchar2(10)      ,/* 資料所有部門 */
mmancrtid       varchar2(20)      ,/* 資料建立者 */
mmancrtdp       varchar2(10)      ,/* 資料建立部門 */
mmancrtdt       timestamp(0)      ,/* 資料創建日 */
mmanmodid       varchar2(20)      ,/* 資料修改者 */
mmanmoddt       timestamp(0)      ,/* 最近修改日 */
mmancnfid       varchar2(20)      ,/* 資料確認者 */
mmancnfdt       timestamp(0)      ,/* 資料確認日 */
mmanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmanud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mman061       varchar2(10)      ,/* 銷售認列方式 */
mman062       varchar2(1)      ,/* 會員價 */
mman063       varchar2(10)      ,/* 會員價選擇 */
mman064       number(5,0)      ,/* 預設折扣率 */
mman065       varchar2(1)      ,/* 儲值付款單次使用否 */
mman066       varchar2(10)      ,/* 卡類型 */
mman067       number(5,0)      ,/* 特價積點基準 */
mman068       number(5,0)      ,/* 特價單位積點 */
mman069       number(20,6)      ,/* 記名累計金額 */
mman070       varchar2(1)      ,/* 用卡支付積分否 */
mman071       varchar2(10)      ,/* 加值類型 */
mman072       varchar2(1)      ,/* 與其他卡種同時使用否 */
mman073       varchar2(1)      /* 參加促銷金額否 */
);
alter table mman_t add constraint mman_pk primary key (mmanent,mman001) enable validate;

create unique index mman_pk on mman_t (mmanent,mman001);

grant select on mman_t to tiptop;
grant update on mman_t to tiptop;
grant delete on mman_t to tiptop;
grant insert on mman_t to tiptop;

exit;
