/* 
================================================================================
檔案代號:ooga_t
檔案名稱:日曆檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooga_t
(
oogaent       number(5)      ,/* 企業編號 */
oogastus       varchar2(10)      ,/* 狀態碼 */
ooga001       date      ,/* 日期 */
ooga002       varchar2(10)      ,/* 星期 */
ooga003       varchar2(40)      ,/* 農曆日期 */
ooga004       varchar2(10)      ,/* 分類一 */
ooga005       varchar2(10)      ,/* 分類二 */
ooga006       varchar2(10)      ,/* 分類三 */
ooga007       varchar2(10)      ,/* 分類四 */
ooga008       varchar2(10)      ,/* 分類五 */
oogaownid       varchar2(20)      ,/* 資料所有者 */
oogaowndp       varchar2(10)      ,/* 資料所屬部門 */
oogacrtid       varchar2(20)      ,/* 資料建立者 */
oogacrtdp       varchar2(10)      ,/* 資料建立部門 */
oogacrtdt       timestamp(0)      ,/* 資料創建日 */
oogamodid       varchar2(20)      ,/* 資料修改者 */
oogamoddt       timestamp(0)      ,/* 最近修改日 */
ooga009       number(5,0)      ,/* 期別 */
ooga010       number(5,0)      ,/* 季別 */
ooga011       number(5,0)      ,/* 週別 */
ooga012       number(5,0)      ,/* 月份 */
ooga013       number(5,0)      ,/* 月週 */
oogaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oogaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oogaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oogaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oogaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oogaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oogaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oogaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oogaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oogaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oogaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oogaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oogaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oogaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oogaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oogaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oogaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oogaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oogaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oogaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oogaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oogaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oogaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oogaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oogaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oogaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oogaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oogaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oogaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oogaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooga_t add constraint ooga_pk primary key (oogaent,ooga001) enable validate;

create  index ooga_01 on ooga_t (ooga002);
create  index ooga_02 on ooga_t (ooga003);
create  index ooga_03 on ooga_t (ooga009);
create  index ooga_04 on ooga_t (ooga010);
create  index ooga_05 on ooga_t (ooga011);
create  index ooga_06 on ooga_t (ooga012);
create  index ooga_07 on ooga_t (ooga013);
create unique index ooga_pk on ooga_t (oogaent,ooga001);

grant select on ooga_t to tiptop;
grant update on ooga_t to tiptop;
grant delete on ooga_t to tiptop;
grant insert on ooga_t to tiptop;

exit;
