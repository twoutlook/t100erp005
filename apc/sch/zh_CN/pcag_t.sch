/* 
================================================================================
檔案代號:pcag_t
檔案名稱:POS角色模組資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcag_t
(
pcagent       number(5)      ,/* 企業編號 */
pcagunit       varchar2(10)      ,/* 應用組織 */
pcag001       varchar2(10)      ,/* 角色編號 */
pcag002       varchar2(40)      ,/* 模塊編號 */
pcag003       varchar2(1)      ,/* 是否可用 */
pcagstus       varchar2(10)      ,/* 狀態碼 */
pcagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcag_t add constraint pcag_pk primary key (pcagent,pcag001,pcag002) enable validate;

create unique index pcag_pk on pcag_t (pcagent,pcag001,pcag002);

grant select on pcag_t to tiptop;
grant update on pcag_t to tiptop;
grant delete on pcag_t to tiptop;
grant insert on pcag_t to tiptop;

exit;
