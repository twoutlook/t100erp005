/* 
================================================================================
檔案代號:inps_t
檔案名稱:週期盤點單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inps_t
(
inpsent       number(5)      ,/* 企業編號 */
inpssite       varchar2(10)      ,/* 營運據點 */
inpsdocno       varchar2(20)      ,/* 標籤編號 */
inps001       varchar2(20)      ,/* 盤點計劃單號 */
inps002       varchar2(255)      ,/* 備註 */
inps003       date      ,/* 列印日期 */
inps004       number(10,0)      ,/* 列印次數 */
inps005       varchar2(10)      ,/* 輸入部門 */
inps006       varchar2(20)      ,/* 輸入人員 */
inps007       date      ,/* 輸入日期 */
inpsstus       varchar2(10)      ,/* 狀態碼 */
inpsownid       varchar2(20)      ,/* 資料所有者 */
inpsowndp       varchar2(10)      ,/* 資料所屬部門 */
inpscrtid       varchar2(20)      ,/* 資料建立者 */
inpscrtdp       varchar2(10)      ,/* 資料建立部門 */
inpscrtdt       timestamp(0)      ,/* 資料創建日 */
inpsmodid       varchar2(20)      ,/* 資料修改者 */
inpsmoddt       timestamp(0)      ,/* 最近修改日 */
inpscnfid       varchar2(20)      ,/* 資料確認者 */
inpscnfdt       timestamp(0)      ,/* 資料確認日 */
inpspstid       varchar2(20)      ,/* 資料過帳者 */
inpspstdt       timestamp(0)      ,/* 資料過帳日 */
inpsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inps_t add constraint inps_pk primary key (inpsent,inpssite,inpsdocno) enable validate;

create unique index inps_pk on inps_t (inpsent,inpssite,inpsdocno);

grant select on inps_t to tiptop;
grant update on inps_t to tiptop;
grant delete on inps_t to tiptop;
grant insert on inps_t to tiptop;

exit;
