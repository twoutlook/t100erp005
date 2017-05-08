/* 
================================================================================
檔案代號:oobf_t
檔案名稱:單據別最大流水號紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobf_t
(
oobfent       number(5)      ,/* 企業編號 */
oobfsite       varchar2(10)      ,/* 營運據點 */
oobf001       varchar2(5)      ,/* 單據據點代號 */
oobf002       varchar2(5)      ,/* 單據別 */
oobf003       varchar2(10)      ,/* 期別碼 */
oobf004       number(5,0)      ,/* 最大流水號 */
oobfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobf_t add constraint oobf_pk primary key (oobfent,oobfsite,oobf001,oobf002,oobf003) enable validate;

create unique index oobf_pk on oobf_t (oobfent,oobfsite,oobf001,oobf002,oobf003);

grant select on oobf_t to tiptop;
grant update on oobf_t to tiptop;
grant delete on oobf_t to tiptop;
grant insert on oobf_t to tiptop;

exit;
