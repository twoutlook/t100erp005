/* 
================================================================================
檔案代號:fmmo_t
檔案名稱:攤餘成本計算表檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmo_t
(
fmmoent       number(5)      ,/* 企業代碼 */
fmmoownid       varchar2(20)      ,/* 資料所有者 */
fmmoowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmocrtid       varchar2(20)      ,/* 資料建立者 */
fmmocrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmocrtdt       timestamp(0)      ,/* 資料創建日 */
fmmomodid       varchar2(20)      ,/* 資料修改者 */
fmmomoddt       timestamp(0)      ,/* 最近修改日 */
fmmo001       varchar2(20)      ,/* 投資購買單號 */
fmmoseq       number(10,0)      ,/* 項次 */
fmmo002       number(5,0)      ,/* 起始年度 */
fmmo003       number(10,0)      ,/* 期別個數 */
fmmo004       number(20,6)      ,/* 期初攤餘成本 */
fmmo005       number(20,6)      ,/* 實際利息 */
fmmo006       number(20,6)      ,/* 現金流入 */
fmmo007       number(20,6)      ,/* 期末攤餘成本 */
fmmo008       number(20,6)      ,/* 利息調整 */
fmmo009       number(10,6)      ,/* 實際利率 */
fmmoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmoud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmo010       number(5,0)      ,/* 起始期別 */
fmmo011       number(5,0)      ,/* 截止年度 */
fmmo012       number(5,0)      /* 截止期別 */
);
alter table fmmo_t add constraint fmmo_pk primary key (fmmoent,fmmo001,fmmoseq) enable validate;

create unique index fmmo_pk on fmmo_t (fmmoent,fmmo001,fmmoseq);

grant select on fmmo_t to tiptop;
grant update on fmmo_t to tiptop;
grant delete on fmmo_t to tiptop;
grant insert on fmmo_t to tiptop;

exit;
