/* 
================================================================================
檔案代號:crcb_t
檔案名稱:客戶調查問卷資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table crcb_t
(
crcbent       number(5)      ,/* 企業編號 */
crcbstus       varchar2(10)      ,/* 資料狀態碼 */
crcbunit       varchar2(10)      ,/* 應用組織 */
crcbsite       varchar2(10)      ,/* 營運據點 */
crcb001       varchar2(10)      ,/* 調查問卷編號 */
crcb002       varchar2(80)      ,/* 制定人員 */
crcb003       varchar2(20)      ,/* 制定部門 */
crcb004       number(15,3)      ,/* 問卷總分 */
crcb005       varchar2(10)      ,/* 備註 */
crcbownid       varchar2(20)      ,/* 資料所有者 */
crcbowndp       varchar2(10)      ,/* 資料所屬部門 */
crcbcrtid       varchar2(20)      ,/* 資料建立者 */
crcbcrtdp       varchar2(10)      ,/* 資料建立部門 */
crcbcrtdt       timestamp(0)      ,/* 資料創建日 */
crcbmodid       varchar2(20)      ,/* 資料修改者 */
crcbmoddt       timestamp(0)      ,/* 最近修改日 */
crcbcnfid       varchar2(20)      ,/* 資料確認者 */
crcbcnfdt       timestamp(0)      ,/* 資料確認日 */
crcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crcbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crcb_t add constraint crcb_pk primary key (crcbent,crcb001) enable validate;

create unique index crcb_pk on crcb_t (crcbent,crcb001);

grant select on crcb_t to tiptop;
grant update on crcb_t to tiptop;
grant delete on crcb_t to tiptop;
grant insert on crcb_t to tiptop;

exit;
