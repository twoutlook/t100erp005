/* 
================================================================================
檔案代號:icai_t
檔案名稱:多角流程式號取號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table icai_t
(
icaient       number(5)      ,/* 企業編號 */
icai001       varchar2(10)      ,/* 流程代碼 */
icai002       varchar2(10)      ,/* 流程類型 */
icai003       varchar2(10)      ,/* 期別碼 */
icai004       number(5,0)      ,/* 最大流水號 */
icaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table icai_t add constraint icai_pk primary key (icaient,icai001,icai002,icai003) enable validate;

create unique index icai_pk on icai_t (icaient,icai001,icai002,icai003);

grant select on icai_t to tiptop;
grant update on icai_t to tiptop;
grant delete on icai_t to tiptop;
grant insert on icai_t to tiptop;

exit;
