/* 
================================================================================
檔案代號:mmak_t
檔案名稱:卡種基本資料申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmak_t
(
mmakent       number(5)      ,/* 企業編號 */
mmakunit       varchar2(10)      ,/* 應用組織 */
mmaksite       varchar2(10)      ,/* 營運據點 */
mmakdocno       varchar2(20)      ,/* 申請單號 */
mmakdocdt       date      ,/* 單據日期 */
mmak000       varchar2(10)      ,/* 申請類別 */
mmak001       varchar2(10)      ,/* 卡種編號 */
mmak002       varchar2(10)      ,/* 版本 */
mmak003       varchar2(1)      ,/* 外社卡 */
mmak004       varchar2(10)      ,/* no use */
mmak005       number(5,0)      ,/* 卡號總碼長 */
mmak006       number(5,0)      ,/* 卡號固定代碼長度 */
mmak007       varchar2(30)      ,/* 卡號固定代碼 */
mmak008       number(5,0)      ,/* 卡號流水碼長度 */
mmak009       varchar2(10)      ,/* 發卡方式 */
mmak010       number(20,6)      ,/* 消費附贈最低消費金額 */
mmak011       number(20,6)      ,/* 購卡金額 */
mmak012       varchar2(40)      ,/* 發卡贈品商品編號 */
mmak013       number(20,6)      ,/* 換卡工本費 */
mmak014       number(20,6)      ,/* 補卡工本費 */
mmak015       varchar2(1)      ,/* 卡記名 */
mmak016       varchar2(1)      ,/* 使用時需開卡 */
mmak017       varchar2(1)      ,/* 卡需設定密碼 */
mmak018       varchar2(1)      ,/* 卡效期控管 */
mmak019       varchar2(10)      ,/* 效期規則起算基準 */
mmak020       varchar2(10)      ,/* 有效期至 */
mmak021       date      ,/* 效期指定日期 */
mmak022       number(5,0)      ,/* 效期指定月份長度 */
mmak023       varchar2(1)      ,/* 卡效期延長 */
mmak024       number(5,0)      ,/* 效期延長月份長度 */
mmak025       number(5,0)      ,/* 效期延長次數 */
mmak026       varchar2(1)      ,/* 會員折扣 */
mmak027       varchar2(1)      ,/* 積點 */
mmak028       varchar2(10)      ,/* 預設積點基準單位 */
mmak029       number(15,3)      ,/* 預設積點基準 */
mmak030       number(15,3)      ,/* 預設單位積點 */
mmak031       varchar2(10)      ,/* 積點清零規則 */
mmak032       number(5,0)      ,/* 積點月後清零 */
mmak033       number(5,0)      ,/* 積點日後清零 */
mmak034       number(5,0)      ,/* 積點指定清零日期-月 */
mmak035       number(5,0)      ,/* 積點指定清零日期-日 */
mmak036       varchar2(10)      ,/* 積點取位 */
mmak037       varchar2(10)      ,/* 取位方法 */
mmak038       varchar2(1)      ,/* 積點抵現 */
mmak039       number(20,6)      ,/* 預設最低抵現消費額 */
mmak040       number(20,6)      ,/* 預設抵現積點基準 */
mmak041       number(20,6)      ,/* 預設抵現單位金額 */
mmak042       varchar2(1)      ,/* 可儲值 */
mmak043       varchar2(1)      ,/* 可重複儲值 */
mmak044       number(20,6)      ,/* 每次儲值金額上限 */
mmak045       number(20,6)      ,/* 每次儲值金額下限 */
mmak046       number(20,6)      ,/* 最高總儲值金額 */
mmak047       varchar2(1)      ,/* 儲值折扣 */
mmak048       number(5,0)      ,/* 預設儲值折扣率 */
mmak049       varchar2(1)      ,/* 儲值加值 */
mmak050       number(20,6)      ,/* 預設加值最低金額條件 */
mmak051       number(20,6)      ,/* 預設加值儲值金額基準 */
mmak052       number(20,6)      ,/* 預設單位加值金額 */
mmak053       varchar2(40)      ,/* 卡種對應商品編號 */
mmak054       varchar2(40)      ,/* 儲值金額對應商品編號 */
mmak055       number(5,0)      ,/* 預設抵現上限比例 */
mmak056       number(20,6)      ,/* 預設抵現上限金額 */
mmak057       varchar2(10)      ,/* 積點抵現對應款別編號 */
mmak058       varchar2(10)      ,/* 儲值對應款別編號 */
mmak059       varchar2(10)      ,/* 卡異動明細產生方式 */
mmak060       varchar2(40)      ,/* 積分對應商品編號 */
mmakacti       varchar2(10)      ,/* 資料有效 */
mmakownid       varchar2(20)      ,/* 資料所有者 */
mmakowndp       varchar2(10)      ,/* 資料所有部門 */
mmakcrtid       varchar2(20)      ,/* 資料建立者 */
mmakcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmakcrtdt       timestamp(0)      ,/* 資料創建日 */
mmakmodid       varchar2(20)      ,/* 資料修改者 */
mmakmoddt       timestamp(0)      ,/* 最近修改日 */
mmakcnfid       varchar2(20)      ,/* 資料確認者 */
mmakcnfdt       timestamp(0)      ,/* 資料確認日 */
mmakstus       varchar2(10)      ,/* 狀態碼 */
mmakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmakud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmak061       varchar2(10)      ,/* 銷售認列方式 */
mmak062       varchar2(1)      ,/* 會員價 */
mmak063       varchar2(10)      ,/* 會員價選擇 */
mmak064       number(5,0)      ,/* 預設折扣率 */
mmak065       varchar2(1)      ,/* 儲值付款單次使用否 */
mmak066       varchar2(10)      ,/* 卡類型 */
mmak067       number(5,0)      ,/* 特價積分基準 */
mmak068       number(5,0)      ,/* 特價單位積分 */
mmak069       number(20,6)      ,/* 記名累計金額 */
mmak070       varchar2(1)      /* 用卡支付積分否 */
);
alter table mmak_t add constraint mmak_pk primary key (mmakent,mmakdocno) enable validate;

create unique index mmak_pk on mmak_t (mmakent,mmakdocno);

grant select on mmak_t to tiptop;
grant update on mmak_t to tiptop;
grant delete on mmak_t to tiptop;
grant insert on mmak_t to tiptop;

exit;
