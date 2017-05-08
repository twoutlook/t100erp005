/* 
================================================================================
檔案代號:isar_t
檔案名稱:發票交易稅明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isar_t
(
isarent       number(5)      ,/* 企業編號 */
isarcomp       varchar2(10)      ,/* 法人 */
isardocno       varchar2(20)      ,/* 開票單號 */
isarseq       number(10,0)      ,/* 項次 */
isar001       varchar2(10)      ,/* 來源單號 */
isar002       varchar2(20)      ,/* 來源項次 */
isar003       varchar2(20)      ,/* 發票數量 */
isar004       number(20,6)      ,/* 單價 */
isar005       number(20,6)      ,/* 固定課稅額 */
isar006       varchar2(10)      ,/* 稅別 */
isar007       varchar2(1)      ,/* 含稅否 */
isar008       number(5,2)      ,/* 稅率 */
isar009       varchar2(20)      ,/* 應收單號 */
isar010       number(10,0)      ,/* 應收單項次 */
isar103       number(20,6)      ,/* 原幣未稅金額 */
isar104       number(20,6)      ,/* 原幣稅額 */
isar105       number(20,6)      ,/* 原幣含稅金額 */
isarud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isarud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isarud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isarud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isarud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isarud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isarud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isarud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isarud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isarud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isarud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isarud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isarud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isarud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isarud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isarud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isarud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isarud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isarud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isarud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isarud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isarud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isarud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isarud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isarud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isarud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isarud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isarud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isarud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isarud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isar_t add constraint isar_pk primary key (isarent,isarcomp,isardocno,isarseq,isar006) enable validate;

create unique index isar_pk on isar_t (isarent,isarcomp,isardocno,isarseq,isar006);

grant select on isar_t to tiptop;
grant update on isar_t to tiptop;
grant delete on isar_t to tiptop;
grant insert on isar_t to tiptop;

exit;
