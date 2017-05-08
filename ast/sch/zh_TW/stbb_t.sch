/* 
================================================================================
檔案代號:stbb_t
檔案名稱:費用單明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbb_t
(
stbbent       number(5)      ,/* 企業編號 */
stbbunit       varchar2(10)      ,/* 應用組織 */
stbbsite       varchar2(10)      ,/* 營運據點 */
stbbdocno       varchar2(20)      ,/* 單據編號 */
stbbseq       number(10,0)      ,/* 項次 */
stbb001       varchar2(10)      ,/* 費用編號 */
stbb002       varchar2(10)      ,/* 幣別 */
stbb003       varchar2(10)      ,/* 稅別 */
stbb004       varchar2(10)      ,/* 價款類別 */
stbb005       date      ,/* 起始日期 */
stbb006       date      ,/* 截止日期 */
stbb007       varchar2(10)      ,/* 結算會計期 */
stbb008       varchar2(10)      ,/* 財務會計期 */
stbb009       number(20,6)      ,/* 費用金額 */
stbb010       varchar2(10)      ,/* 承擔對象 */
stbb011       varchar2(10)      ,/* 所屬品類 */
stbb012       varchar2(10)      ,/* 所屬部門 */
stbb013       varchar2(10)      ,/* 結算對象 */
stbbud001       varchar2(40)      ,/* 含發票否 */
stbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stbb014       number(5,0)      ,/* 財務會計期別 */
stbb015       varchar2(1)      ,/* 納入結算單否 */
stbb016       varchar2(1)      ,/* 票扣否 */
stbb017       varchar2(255)      ,/* 備註 */
stbb018       number(10,0)      ,/* 結算帳期 */
stbb019       date      ,/* 結算日期 */
stbb020       varchar2(10)      ,/* 日結成本類型 */
stbb021       date      ,/* 調整日期 */
stbb022       varchar2(40)      ,/* 商品編號 */
stbb023       varchar2(10)      ,/* 庫區編號 */
stbb024       varchar2(20)      ,/* 专柜编号 */
stbb025       number(20,6)      ,/* 應收金額 */
stbb026       number(20,6)      ,/* 實收金額 */
stbb027       number(20,6)      ,/* 費率 */
stbb028       number(20,6)      ,/* 成本金額 */
stbb029       number(20,6)      ,/* 促銷銷售額 */
stbb030       varchar2(10)      ,/* 費用歸屬類型 */
stbb031       varchar2(10)      ,/* 費用歸屬組織 */
stbb032       number(20,6)      ,/* 銷售數量 */
stbb033       varchar2(10)      /* 銷售單位 */
);
alter table stbb_t add constraint stbb_pk primary key (stbbent,stbbdocno,stbbseq) enable validate;

create unique index stbb_pk on stbb_t (stbbent,stbbdocno,stbbseq);

grant select on stbb_t to tiptop;
grant update on stbb_t to tiptop;
grant delete on stbb_t to tiptop;
grant insert on stbb_t to tiptop;

exit;
