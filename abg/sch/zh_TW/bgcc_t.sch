/* 
================================================================================
檔案代號:bgcc_t
檔案名稱:銷售模擬收入項目主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgcc_t
(
bgccent       number(5)      ,/* 企業編號 */
bgcc001       varchar2(10)      ,/* 模擬收入項目 */
bgccstus       varchar2(10)      ,/* 狀態碼 */
bgccownid       varchar2(20)      ,/* 資料所有者 */
bgccowndp       varchar2(10)      ,/* 資料所屬部門 */
bgcccrtid       varchar2(20)      ,/* 資料建立者 */
bgcccrtdp       varchar2(10)      ,/* 資料建立部門 */
bgcccrtdt       timestamp(0)      ,/* 資料創建日 */
bgccmodid       varchar2(20)      ,/* 資料修改者 */
bgccmoddt       timestamp(0)      ,/* 最近修改日 */
bgccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgcc_t add constraint bgcc_pk primary key (bgccent,bgcc001) enable validate;

create unique index bgcc_pk on bgcc_t (bgccent,bgcc001);

grant select on bgcc_t to tiptop;
grant update on bgcc_t to tiptop;
grant delete on bgcc_t to tiptop;
grant insert on bgcc_t to tiptop;

exit;
