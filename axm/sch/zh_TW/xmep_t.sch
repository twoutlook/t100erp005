/* 
================================================================================
檔案代號:xmep_t
檔案名稱:地磅單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmep_t
(
xmepent       number(5)      ,/* 企業編號 */
xmepsite       varchar2(10)      ,/* 營運據點 */
xmepdocno       varchar2(20)      ,/* 地磅單號 */
xmep001       varchar2(10)      ,/* 出入原因 */
xmep002       varchar2(20)      ,/* 派車單單號 */
xmep003       varchar2(10)      ,/* 車牌號碼 */
xmep004       varchar2(20)      ,/* 駕駛員 */
xmep005       varchar2(10)      ,/* 運輸公司 */
xmep006       number(20,6)      ,/* 進廠重量 */
xmep007       varchar2(10)      ,/* 進廠單位 */
xmep008       date      ,/* 進廠日期 */
xmep009       varchar2(8)      ,/* 進廠時間 */
xmep010       number(20,6)      ,/* 出廠重量 */
xmep011       varchar2(10)      ,/* 出廠單位 */
xmep012       date      ,/* 出廠日期 */
xmep013       varchar2(8)      ,/* 出廠時間 */
xmep014       number(20,6)      ,/* 進出重量差 */
xmepownid       varchar2(20)      ,/* 資料所有者 */
xmepowndp       varchar2(10)      ,/* 資料所屬部門 */
xmepcrtid       varchar2(20)      ,/* 資料建立者 */
xmepcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmepcrtdt       timestamp(0)      ,/* 資料創建日 */
xmepmodid       varchar2(20)      ,/* 資料修改者 */
xmepmoddt       timestamp(0)      ,/* 最近修改日 */
xmepcnfid       varchar2(20)      ,/* 資料確認者 */
xmepcnfdt       timestamp(0)      ,/* 資料確認日 */
xmeppstid       varchar2(20)      ,/* 資料過帳者 */
xmeppstdt       timestamp(0)      ,/* 資料過帳日 */
xmepstus       varchar2(10)      ,/* 狀態碼 */
xmepdocdt       date      ,/* 單據日期 */
xmepud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmepud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmepud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmepud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmepud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmepud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmepud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmepud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmepud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmepud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmepud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmepud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmepud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmepud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmepud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmepud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmepud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmepud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmepud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmepud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmepud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmepud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmepud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmepud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmepud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmepud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmepud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmepud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmepud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmepud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmep_t add constraint xmep_pk primary key (xmepent,xmepdocno) enable validate;

create unique index xmep_pk on xmep_t (xmepent,xmepdocno);

grant select on xmep_t to tiptop;
grant update on xmep_t to tiptop;
grant delete on xmep_t to tiptop;
grant insert on xmep_t to tiptop;

exit;
