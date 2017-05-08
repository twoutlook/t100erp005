/* 
================================================================================
檔案代號:glaw_t
檔案名稱:帳別科目對應檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glaw_t
(
glawent       number(5)      ,/* 企業編號 */
glawownid       varchar2(20)      ,/* 資料所有者 */
glawowndp       varchar2(10)      ,/* 資料所屬部門 */
glawcrtid       varchar2(20)      ,/* 資料建立者 */
glawcrtdp       varchar2(10)      ,/* 資料建立部門 */
glawcrtdt       timestamp(0)      ,/* 資料創建日 */
glawmodid       varchar2(20)      ,/* 資料修改者 */
glawmoddt       timestamp(0)      ,/* 最近修改日 */
glawstus       varchar2(10)      ,/* 狀態碼 */
glaw001       varchar2(5)      ,/* 來源帳別 */
glaw002       varchar2(24)      ,/* 來源科目 */
glaw003       varchar2(5)      ,/* 對應帳別 */
glaw004       varchar2(24)      ,/* 對應科目 */
glaw005       number(20,6)      ,/* 對應比例 */
glaw006       date      ,/* 生效日期 */
glaw007       date      ,/* 失效日期 */
glawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glawud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glaw_t add constraint glaw_pk primary key (glawent,glaw001,glaw002,glaw003,glaw004) enable validate;

create unique index glaw_pk on glaw_t (glawent,glaw001,glaw002,glaw003,glaw004);

grant select on glaw_t to tiptop;
grant update on glaw_t to tiptop;
grant delete on glaw_t to tiptop;
grant insert on glaw_t to tiptop;

exit;
