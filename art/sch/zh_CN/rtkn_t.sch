/* 
================================================================================
檔案代號:rtkn_t
檔案名稱:補貨建議單明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtkn_t
(
rtknent       number(5)      ,/* 企業編號 */
rtknunit       varchar2(10)      ,/* 應用組織 */
rtknsite       varchar2(10)      ,/* 營運據點 */
rtkndocno       varchar2(20)      ,/* 單據編號 */
rtknseq       number(10,0)      ,/* 項次 */
rtkn001       varchar2(40)      ,/* 商品編號 */
rtkn002       varchar2(40)      ,/* 商品條碼 */
rtkn003       varchar2(256)      ,/* 商品特徵 */
rtkn004       varchar2(10)      ,/* 品類編號 */
rtkn005       varchar2(10)      ,/* 採購類型 */
rtkn006       varchar2(10)      ,/* 供應商 */
rtkn007       varchar2(10)      ,/* 庫存單位 */
rtkn008       number(20,6)      ,/* 要貨數量 */
rtkn009       number(20,6)      ,/* 要貨金額 */
rtkn010       date      ,/* 到貨日 */
rtkn011       date      ,/* 促銷開始日 */
rtkn012       date      ,/* 促銷結束日 */
rtkn101a       number(5,0)      ,/* 安全庫存天數 */
rtkn101b       number(5,0)      ,/* 要貨頻率 */
rtkn101c       number(5,0)      ,/* 送貨天數 */
rtkn101d       number(20,6)      ,/* 門店備貨週期校正係數 */
rtkn101       number(5,0)      ,/* 備貨天數 */
rtkn201a       number(20,6)      ,/* 日均銷量 */
rtkn201b       number(15,3)      ,/* 到貨日品類周參數A */
rtkn201c       number(15,3)      ,/* 到貨日品類日驅勢參數 */
rtkn201d       number(5,0)      ,/* 備貨天數 */
rtkn201e       number(5,0)      ,/* 最小庫存天數 */
rtkn201f       number(20,6)      ,/* 最小庫存量 */
rtkn201g       number(20,6)      ,/* 特殊陳列量 */
rtkn201       number(20,6)      ,/* 安全庫存量1 */
rtkn202       number(20,6)      ,/* 安全庫存量2 */
rtkn203       number(20,6)      ,/* 安全庫存量3 */
rtkn204       number(20,6)      ,/* 安全庫存量 */
rtkn301a       number(20,6)      ,/* 日均銷量 */
rtkn301b       number(15,3)      ,/* 到貨日品類周參數A */
rtkn301c       number(15,3)      ,/* 到貨日品類日驅勢參數 */
rtkn301d       number(5,0)      ,/* 備貨天數 */
rtkn301e       number(5,0)      ,/* 年節天數 */
rtkn301f       number(20,6)      ,/* 促銷日均銷量PDMS */
rtkn301g       number(15,3)      ,/* AVG(起始-結束日品類周參數A) */
rtkn301h       number(5,0)      ,/* 休假天數 */
rtkn301       number(20,6)      ,/* 促銷庫存增量 */
rtkn302       number(20,6)      ,/* 年節備貨增量 */
rtkn303       number(20,6)      ,/* 休假備貨增量 */
rtkn401a       number(20,6)      ,/* 日均銷量DMS */
rtkn401b       number(15,3)      ,/* 到貨日品類周參數A */
rtkn401c       number(15,3)      ,/* 到貨日品類日驅勢參數 */
rtkn401d       number(20,6)      ,/* 安全庫存量 */
rtkn401e       number(20,6)      ,/* 促銷庫存增量 */
rtkn401f       number(20,6)      ,/* 年節備貨增量 */
rtkn401g       number(20,6)      ,/* 休假備貨增量 */
rtkn401h       number(20,6)      ,/* 目標庫存天數 */
rtkn401       number(20,6)      ,/* 目標庫存量 */
rtkn501a       number(20,6)      ,/* 目標庫存量 */
rtkn501b       number(20,6)      ,/* 當前庫存量 */
rtkn501c       number(20,6)      ,/* 在途出庫量 */
rtkn501d       number(20,6)      ,/* 在途入庫量 */
rtkn501       number(20,6)      ,/* 建議補貨量 */
rtknud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtknud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtknud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtknud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtknud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtknud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtknud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtknud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtknud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtknud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtknud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtknud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtknud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtknud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtknud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtknud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtknud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtknud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtknud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtknud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtknud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtknud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtknud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtknud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtknud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtknud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtknud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtknud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtknud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtknud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkn_t add constraint rtkn_pk primary key (rtknent,rtkndocno,rtknseq) enable validate;

create unique index rtkn_pk on rtkn_t (rtknent,rtkndocno,rtknseq);

grant select on rtkn_t to tiptop;
grant update on rtkn_t to tiptop;
grant delete on rtkn_t to tiptop;
grant insert on rtkn_t to tiptop;

exit;
