/* 
================================================================================
檔案代號:gzxf_t
檔案名稱:使用者臨時密碼紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxf_t
(
gzxfent       number(5)      ,/* 企業編號 */
gzxf001       varchar2(20)      ,/* 用戶編號 */
gzxf002       timestamp(0)      ,/* 啟用日期時間 */
gzxf003       timestamp(0)      ,/* 截止日期時間 */
gzxf004       varchar2(80)      ,/* 用戶密碼 */
gzxfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxf_t add constraint gzxf_pk primary key (gzxfent,gzxf001) enable validate;

create unique index gzxf_pk on gzxf_t (gzxfent,gzxf001);

grant select on gzxf_t to tiptop;
grant update on gzxf_t to tiptop;
grant delete on gzxf_t to tiptop;
grant insert on gzxf_t to tiptop;

exit;
