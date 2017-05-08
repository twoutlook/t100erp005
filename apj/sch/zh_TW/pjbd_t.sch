/* 
================================================================================
檔案代號:pjbd_t
檔案名稱:專案WBS材料預算檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbd_t
(
pjbdent       number(5)      ,/* 企業編號 */
pjbd001       varchar2(20)      ,/* 專案編號 */
pjbd002       varchar2(30)      ,/* 本階WBS */
pjbd003       number(10,0)      ,/* 項次 */
pjbd004       varchar2(10)      ,/* 產品分類 */
pjbd005       varchar2(40)      ,/* 限定料號 */
pjbd006       varchar2(10)      ,/* 單位 */
pjbd007       number(20,6)      ,/* 數量 */
pjbd008       number(20,6)      ,/* 單價 */
pjbd009       number(20,6)      ,/* 金額 */
pjbd010       varchar2(255)      ,/* 補充說明 */
pjbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbdud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbd011       number(20,6)      ,/* 已轉請購量 */
pjbd012       varchar2(10)      ,/* 幣別 */
pjbd013       number(20,10)      ,/* 匯率 */
pjbd014       varchar2(10)      ,/* 稅別 */
pjbd015       number(5,2)      ,/* 稅率 */
pjbd016       number(20,6)      ,/* 原幣含稅金額 */
pjbd017       number(20,6)      ,/* 原幣稅額 */
pjbd018       number(20,6)      ,/* 本幣未稅金額 */
pjbd019       number(20,6)      ,/* 本幣含稅金額 */
pjbd020       number(20,6)      ,/* 本幣稅額 */
pjbd021       varchar2(256)      /* 產品特徵 */
);
alter table pjbd_t add constraint pjbd_pk primary key (pjbdent,pjbd001,pjbd002,pjbd003) enable validate;

create unique index pjbd_pk on pjbd_t (pjbdent,pjbd001,pjbd002,pjbd003);

grant select on pjbd_t to tiptop;
grant update on pjbd_t to tiptop;
grant delete on pjbd_t to tiptop;
grant insert on pjbd_t to tiptop;

exit;
