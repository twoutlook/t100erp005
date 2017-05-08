/* 
================================================================================
檔案代號:gzyd_t
檔案名稱:職能角色欄位授權設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzyd_t
(
gzydent       number(5)      ,/* 企業編號 */
gzyd001       varchar2(10)      ,/* 職能角色編號 */
gzyd002       varchar2(20)      ,/* 作業編號 */
gzyd003       varchar2(80)      ,/* 欄位編號 */
gzyd004       varchar2(1)      ,/* 欄位授權動作 */
gzyd005       varchar2(80)      ,/* 欄位加密方法 */
gzydud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzydud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzydud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzydud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzydud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzydud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzydud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzydud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzydud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzydud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzydud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzydud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzydud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzydud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzydud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzydud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzydud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzydud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzydud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzydud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzydud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzydud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzydud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzydud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzydud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzydud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzydud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzydud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzydud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzydud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzyd_t add constraint gzyd_pk primary key (gzydent,gzyd001,gzyd002,gzyd003) enable validate;

create unique index gzyd_pk on gzyd_t (gzydent,gzyd001,gzyd002,gzyd003);

grant select on gzyd_t to tiptop;
grant update on gzyd_t to tiptop;
grant delete on gzyd_t to tiptop;
grant insert on gzyd_t to tiptop;

exit;
