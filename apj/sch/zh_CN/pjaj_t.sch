/* 
================================================================================
檔案代號:pjaj_t
檔案名稱:已採未驗估列
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjaj_t
(
pjajent       number(5)      ,/* 企業編號 */
pjajsite       varchar2(10)      ,/* 營運據點 */
pjaj001       varchar2(20)      ,/* 請購單號 */
pjaj002       number(10,0)      ,/* 請購項次 */
pjaj003       varchar2(10)      ,/* 幣別 */
pjaj004       number(20,10)      ,/* 匯率 */
pjaj005       varchar2(10)      ,/* 稅別 */
pjaj006       varchar2(1)      ,/* 含稅否 */
pjaj007       number(5,2)      ,/* 稅率 */
pjaj008       varchar2(40)      ,/* 料號 */
pjaj009       varchar2(256)      ,/* 產品特徵 */
pjaj010       number(20,6)      ,/* 單價 */
pjaj011       number(20,6)      ,/* 需求數量 */
pjaj012       number(20,6)      ,/* 已收貨量 */
pjaj013       number(20,6)      ,/* 未收量原幣未稅 */
pjaj014       number(20,6)      ,/* 未收量本幣未稅 */
pjajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjajud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjaj015       date      ,/* 採購日期 */
pjaj016       varchar2(20)      /* 專案編號 */
);
alter table pjaj_t add constraint pjaj_pk primary key (pjajent,pjajsite,pjaj001,pjaj002) enable validate;

create unique index pjaj_pk on pjaj_t (pjajent,pjajsite,pjaj001,pjaj002);

grant select on pjaj_t to tiptop;
grant update on pjaj_t to tiptop;
grant delete on pjaj_t to tiptop;
grant insert on pjaj_t to tiptop;

exit;
