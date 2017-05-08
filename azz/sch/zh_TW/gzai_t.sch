/* 
================================================================================
檔案代號:gzai_t
檔案名稱:應用分類客製參考欄位畫面設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzai_t
(
gzai001       number(5)      ,/* 應用分類 */
gzai002       varchar2(6)      ,/* 語言別 */
gzai003       varchar2(500)      ,/* 客製參考欄位一 */
gzai004       varchar2(500)      ,/* 客製參考欄位二 */
gzai005       varchar2(500)      ,/* 客製參考欄位三 */
gzai006       varchar2(500)      ,/* 客製參考欄位四 */
gzai007       varchar2(500)      ,/* 客製參考欄位五 */
gzai008       varchar2(500)      ,/* 客製參考欄位六 */
gzai009       varchar2(500)      ,/* 客製參考欄位七 */
gzai010       varchar2(500)      ,/* 客製參考欄位八 */
gzai011       varchar2(500)      ,/* 客製參考欄位九 */
gzai012       varchar2(500)      ,/* 客製參考欄位十 */
gzai013       varchar2(500)      ,/* 客製參考欄位十一 */
gzai014       varchar2(500)      ,/* 客製參考欄位十二 */
gzai015       varchar2(500)      ,/* 客製參考欄位十三 */
gzai016       varchar2(500)      ,/* 客製參考欄位十四 */
gzai017       varchar2(500)      ,/* 客製參考欄位十五 */
gzai018       varchar2(500)      ,/* 客製參考欄位十六 */
gzai019       varchar2(500)      ,/* 客製參考欄位十七 */
gzai020       varchar2(500)      ,/* 客製參考欄位十八 */
gzai021       varchar2(500)      ,/* 客製參考欄位十九 */
gzai022       varchar2(500)      ,/* 客製參考欄位二十 */
gzaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzai_t add constraint gzai_pk primary key (gzai001,gzai002) enable validate;

create unique index gzai_pk on gzai_t (gzai001,gzai002);

grant select on gzai_t to tiptop;
grant update on gzai_t to tiptop;
grant delete on gzai_t to tiptop;
grant insert on gzai_t to tiptop;

exit;
