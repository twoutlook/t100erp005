/* 
================================================================================
檔案代號:gzxo_t
檔案名稱:查詢方案群組設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxo_t
(
gzxostus       varchar2(10)      ,/* 狀態碼 */
gzxoent       number(5)      ,/* 企業編號 */
gzxo001       number(10,0)      ,/* 群組編號 */
gzxo002       varchar2(20)      ,/* 作業編號 */
gzxo003       varchar2(20)      ,/* 員工編號 */
gzxoownid       varchar2(20)      ,/* 資料所有者 */
gzxoowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxocrtid       varchar2(20)      ,/* 資料建立者 */
gzxocrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxocrtdt       timestamp(0)      ,/* 資料創建日 */
gzxomodid       varchar2(20)      ,/* 資料修改者 */
gzxomoddt       timestamp(0)      ,/* 最近修改日 */
gzxo004       number(10,0)      ,/* 順序 */
gzxoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxo_t add constraint gzxo_pk primary key (gzxoent,gzxo001,gzxo002,gzxo003) enable validate;

create unique index gzxo_pk on gzxo_t (gzxoent,gzxo001,gzxo002,gzxo003);

grant select on gzxo_t to tiptop;
grant update on gzxo_t to tiptop;
grant delete on gzxo_t to tiptop;
grant insert on gzxo_t to tiptop;

exit;
