/* 
================================================================================
檔案代號:xmfa_t
檔案名稱:銷售報價範本單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmfa_t
(
xmfaent       number(5)      ,/* 企業編號 */
xmfasite       varchar2(10)      ,/* 營運據點 */
xmfadocno       varchar2(20)      ,/* 範本料號 */
xmfa001       number(5,0)      ,/* 版次 */
xmfaownid       varchar2(20)      ,/* 資料所有者 */
xmfaowndp       varchar2(10)      ,/* 資料所屬部門 */
xmfacrtid       varchar2(20)      ,/* 資料建立者 */
xmfacrtdp       varchar2(10)      ,/* 資料建立部門 */
xmfacrtdt       timestamp(0)      ,/* 資料創建日 */
xmfamodid       varchar2(20)      ,/* 資料修改者 */
xmfamoddt       timestamp(0)      ,/* 最近修改日 */
xmfastus       varchar2(10)      ,/* 狀態碼 */
xmfaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfa_t add constraint xmfa_pk primary key (xmfaent,xmfadocno,xmfa001) enable validate;

create unique index xmfa_pk on xmfa_t (xmfaent,xmfadocno,xmfa001);

grant select on xmfa_t to tiptop;
grant update on xmfa_t to tiptop;
grant delete on xmfa_t to tiptop;
grant insert on xmfa_t to tiptop;

exit;
