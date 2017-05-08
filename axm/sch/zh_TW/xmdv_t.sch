/* 
================================================================================
檔案代號:xmdv_t
檔案名稱:核價分量計價檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdv_t
(
xmdvent       number(5)      ,/* 企業編號 */
xmdvsite       varchar2(10)      ,/* 營運據點 */
xmdvdocno       varchar2(20)      ,/* 單號 */
xmdvseq       number(10,0)      ,/* 項次 */
xmdv001       number(20,6)      ,/* 起始數量 */
xmdv002       number(20,6)      ,/* 截止數量 */
xmdv003       number(20,6)      ,/* 單價 */
xmdv004       number(20,6)      ,/* 折扣率 */
xmdvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdv_t add constraint xmdv_pk primary key (xmdvent,xmdvdocno,xmdvseq,xmdv001,xmdv002) enable validate;

create unique index xmdv_pk on xmdv_t (xmdvent,xmdvdocno,xmdvseq,xmdv001,xmdv002);

grant select on xmdv_t to tiptop;
grant update on xmdv_t to tiptop;
grant delete on xmdv_t to tiptop;
grant insert on xmdv_t to tiptop;

exit;
