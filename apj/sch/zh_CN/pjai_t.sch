/* 
================================================================================
檔案代號:pjai_t
檔案名稱:已請未採估列檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjai_t
(
pjaient       number(5)      ,/* 企業編號 */
pjaisite       varchar2(10)      ,/* 營運據點 */
pjai001       varchar2(20)      ,/* 請購單號 */
pjai002       number(10,0)      ,/* 請購項次 */
pjai003       varchar2(10)      ,/* 幣別 */
pjai004       number(20,10)      ,/* 匯率 */
pjai005       varchar2(10)      ,/* 稅別 */
pjai006       varchar2(1)      ,/* 含稅否 */
pjai007       number(5,2)      ,/* 稅率 */
pjai008       varchar2(40)      ,/* 料號 */
pjai009       varchar2(256)      ,/* 產品特徵 */
pjai010       number(20,6)      ,/* 需求數量 */
pjai011       number(20,6)      ,/* 已轉採購量 */
pjai012       number(20,6)      ,/* 單價 */
pjai013       number(20,6)      ,/* 未轉量原幣未稅 */
pjai014       number(20,6)      ,/* 未轉量本幣未稅 */
pjaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjaiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjai015       date      ,/* 請購日期 */
pjai016       varchar2(20)      /* 專案編號 */
);
alter table pjai_t add constraint pjai_pk primary key (pjaient,pjaisite,pjai001,pjai002) enable validate;

create unique index pjai_pk on pjai_t (pjaient,pjaisite,pjai001,pjai002);

grant select on pjai_t to tiptop;
grant update on pjai_t to tiptop;
grant delete on pjai_t to tiptop;
grant insert on pjai_t to tiptop;

exit;
