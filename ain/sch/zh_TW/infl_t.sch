/* 
================================================================================
檔案代號:infl_t
檔案名稱:貨架商品變動明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table infl_t
(
inflent       number(5)      ,/* 企業編號 */
inflsite       varchar2(10)      ,/* 營運據點 */
infl001       varchar2(20)      ,/* 單號編號 */
infl002       number(10,0)      ,/* 項次 */
infl003       number(10,0)      ,/* 項序 */
infl004       number(5,0)      ,/* 方向 */
infl005       varchar2(40)      ,/* 商品編號 */
infl006       varchar2(256)      ,/* 商品特征 */
infl007       varchar2(40)      ,/* 貨架編號 */
infl008       varchar2(10)      ,/* 交易單位 */
infl009       number(20,6)      ,/* 數量 */
infl010       number(20,6)      ,/* 交易單位與庫存單位轉換率 */
infl011       date      ,/* 單據日期 */
infl012       date      ,/* 實際變動日期 */
infl013       varchar2(8)      ,/* 實際變動時間 */
infl014       varchar2(20)      ,/* 操作人 */
infl015       varchar2(20)      ,/* 作業編號 */
influd001       varchar2(40)      ,/* 自定義欄位(文字)001 */
influd002       varchar2(40)      ,/* 自定義欄位(文字)002 */
influd003       varchar2(40)      ,/* 自定義欄位(文字)003 */
influd004       varchar2(40)      ,/* 自定義欄位(文字)004 */
influd005       varchar2(40)      ,/* 自定義欄位(文字)005 */
influd006       varchar2(40)      ,/* 自定義欄位(文字)006 */
influd007       varchar2(40)      ,/* 自定義欄位(文字)007 */
influd008       varchar2(40)      ,/* 自定義欄位(文字)008 */
influd009       varchar2(40)      ,/* 自定義欄位(文字)009 */
influd010       varchar2(40)      ,/* 自定義欄位(文字)010 */
influd011       number(20,6)      ,/* 自定義欄位(數字)011 */
influd012       number(20,6)      ,/* 自定義欄位(數字)012 */
influd013       number(20,6)      ,/* 自定義欄位(數字)013 */
influd014       number(20,6)      ,/* 自定義欄位(數字)014 */
influd015       number(20,6)      ,/* 自定義欄位(數字)015 */
influd016       number(20,6)      ,/* 自定義欄位(數字)016 */
influd017       number(20,6)      ,/* 自定義欄位(數字)017 */
influd018       number(20,6)      ,/* 自定義欄位(數字)018 */
influd019       number(20,6)      ,/* 自定義欄位(數字)019 */
influd020       number(20,6)      ,/* 自定義欄位(數字)020 */
influd021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
influd022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
influd023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
influd024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
influd025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
influd026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
influd027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
influd028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
influd029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
influd030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infl_t add constraint infl_pk primary key (inflent,inflsite,infl001,infl002,infl003,infl004) enable validate;

create unique index infl_pk on infl_t (inflent,inflsite,infl001,infl002,infl003,infl004);

grant select on infl_t to tiptop;
grant update on infl_t to tiptop;
grant delete on infl_t to tiptop;
grant insert on infl_t to tiptop;

exit;
