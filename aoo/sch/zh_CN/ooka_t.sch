/* 
================================================================================
檔案代號:ooka_t
檔案名稱:異常管理節點維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooka_t
(
ookaent       number(5)      ,/* 企業編號 */
ooka001       varchar2(10)      ,/* 節點編號 */
ooka002       varchar2(10)      ,/* 模組 */
ooka003       varchar2(20)      ,/* 檢核來源報表 */
ooka004       varchar2(4000)      ,/* 異常條件 */
ooka005       varchar2(4000)      ,/* 警告條件 */
ooka006       varchar2(1)      ,/* 客製 */
ookaownid       varchar2(20)      ,/* 資料所屬者 */
ookaowndp       varchar2(10)      ,/* 資料所屬部門 */
ookacrtid       varchar2(20)      ,/* 資料建立者 */
ookacrtdp       varchar2(10)      ,/* 資料建立部門 */
ookacrtdt       timestamp(0)      ,/* 資料創建日 */
ookamodid       varchar2(20)      ,/* 資料修改者 */
ookamoddt       timestamp(0)      ,/* 最近修改日 */
ookastus       varchar2(10)      ,/* 狀態碼 */
ookaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ookaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ookaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ookaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ookaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ookaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ookaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ookaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ookaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ookaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ookaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ookaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ookaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ookaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ookaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ookaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ookaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ookaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ookaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ookaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ookaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ookaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ookaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ookaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ookaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ookaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ookaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ookaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ookaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ookaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooka_t add constraint ooka_pk primary key (ookaent,ooka001) enable validate;

create unique index ooka_pk on ooka_t (ookaent,ooka001);

grant select on ooka_t to tiptop;
grant update on ooka_t to tiptop;
grant delete on ooka_t to tiptop;
grant insert on ooka_t to tiptop;

exit;
