/* 
================================================================================
檔案代號:mmed_t
檔案名稱:會員卡儲值資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmed_t
(
mmedent       number(5)      ,/* 企業編號 */
mmedsite       varchar2(10)      ,/* 營運據點 */
mmedunit       varchar2(10)      ,/* 應用組織 */
mmeddocno       varchar2(20)      ,/* 單據編號 */
mmedseq       number(10,0)      ,/* 項次 */
mmed001       varchar2(30)      ,/* 儲值卡號 */
mmed002       number(20,6)      ,/* 儲值卡餘額 */
mmed003       number(20,6)      ,/* 卡內儲值成本 */
mmed004       number(5,0)      ,/* 異動類型 */
mmed005       number(20,6)      ,/* 儲值金額 */
mmed006       number(20,6)      ,/* 折扣比率 */
mmed007       number(20,6)      ,/* 折扣金額 */
mmed008       number(20,6)      ,/* 加值金額 */
mmed009       number(20,6)      ,/* 此次儲值成本 */
mmed010       number(20,6)      ,/* 儲值後卡內餘額 */
mmed011       number(20,6)      ,/* 儲值後卡內成本 */
mmed012       number(20,6)      ,/* 實際應付金額 */
mmed013       varchar2(10)      ,/* 庫區 */
mmed014       varchar2(10)      ,/* 理由碼 */
mmedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmedud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mmed100       varchar2(40)      /* GUID */
);
alter table mmed_t add constraint mmed_pk primary key (mmedent,mmeddocno,mmedseq) enable validate;

create unique index mmed_pk on mmed_t (mmedent,mmeddocno,mmedseq);

grant select on mmed_t to tiptop;
grant update on mmed_t to tiptop;
grant delete on mmed_t to tiptop;
grant insert on mmed_t to tiptop;

exit;
