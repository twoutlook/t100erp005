/* 
================================================================================
檔案代號:gzac_t
檔案名稱:應用分類參考欄位畫面設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table gzac_t
(
gzac001       number(5)      ,/* 應用分類 */
gzac002       varchar2(6)      ,/* 語言別 */
gzac003       varchar2(500)      ,/* 參考欄位一 */
gzac004       varchar2(500)      ,/* 參考欄位二 */
gzac005       varchar2(500)      ,/* 參考欄位三 */
gzac006       varchar2(500)      ,/* 參考欄位四 */
gzac007       varchar2(500)      ,/* 參考欄位五 */
gzac008       varchar2(500)      ,/* 參考欄位六 */
gzac009       varchar2(500)      ,/* 參考欄位七 */
gzac010       varchar2(500)      ,/* 參考欄位八 */
gzac011       varchar2(500)      ,/* 參考欄位九 */
gzac012       varchar2(500)      ,/* 參考欄位十 */
gzac013       varchar2(500)      ,/* 參考欄位十一 */
gzac014       varchar2(500)      ,/* 參考欄位十二 */
gzac015       varchar2(500)      ,/* 參考欄位十三 */
gzac016       varchar2(500)      ,/* 參考欄位十四 */
gzac017       varchar2(500)      ,/* 參考欄位十五 */
gzac018       varchar2(500)      ,/* 參考欄位十六 */
gzac019       varchar2(500)      ,/* 參考欄位十七 */
gzac020       varchar2(500)      ,/* 參考欄位十八 */
gzac021       varchar2(500)      ,/* 參考欄位十九 */
gzac022       varchar2(500)      ,/* 參考欄位二十 */
gzac023       varchar2(500)      ,/* 應用分類碼 */
gzac024       varchar2(500)      ,/* 上層應用分類碼 */
gzacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzac_t add constraint gzac_pk primary key (gzac001,gzac002) enable validate;

create unique index gzac_pk on gzac_t (gzac001,gzac002);

grant select on gzac_t to tiptop;
grant update on gzac_t to tiptop;
grant delete on gzac_t to tiptop;
grant insert on gzac_t to tiptop;

exit;
