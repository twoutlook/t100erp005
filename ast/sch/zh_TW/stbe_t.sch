/* 
================================================================================
檔案代號:stbe_t
檔案名稱:結算單明細資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbe_t
(
stbeent       number(5)      ,/* 企業編號 */
stbesite       varchar2(10)      ,/* 營運據點 */
stbecomp       varchar2(10)      ,/* 所屬法人 */
stbedocno       varchar2(20)      ,/* 單據編號 */
stbeseq       number(10,0)      ,/* 單據項次 */
stbe001       varchar2(10)      ,/* 來源類別 */
stbe002       varchar2(20)      ,/* 來源單據 */
stbe003       number(10,0)      ,/* 來源項次 */
stbe004       date      ,/* 來源日期 */
stbe005       varchar2(10)      ,/* 費用編號 */
stbe006       date      ,/* 起始日期 */
stbe007       date      ,/* 截止日期 */
stbe008       varchar2(10)      ,/* 幣別 */
stbe009       varchar2(10)      ,/* 稅別 */
stbe010       varchar2(10)      ,/* 價款類別 */
stbe011       number(5,0)      ,/* 方向 */
stbe012       number(20,6)      ,/* 價外金額 */
stbe013       number(20,6)      ,/* 價內金額 */
stbe014       number(20,6)      ,/* 未結算金額 */
stbe015       number(20,6)      ,/* 已結算金額 */
stbe016       number(20,6)      ,/* 本次結算金額 */
stbe017       varchar2(10)      ,/* 結算方式 */
stbe018       varchar2(10)      ,/* 結算類型 */
stbe019       varchar2(10)      ,/* 所屬品類 */
stbe020       varchar2(10)      ,/* 所屬部門 */
stbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stbe021       number(20,6)      ,/* 主帳套帳款金額 */
stbe022       number(20,6)      ,/* 次帳套一帳款金額 */
stbe023       number(20,6)      ,/* 次帳套二帳款金額 */
stbe024       varchar2(1)      ,/* 納入結算單否 */
stbe025       varchar2(1)      ,/* 票扣否 */
stbe026       number(20,6)      ,/* 數量 */
stbe027       number(20,6)      ,/* 單價 */
stbe028       varchar2(20)      ,/* 专柜编号 */
stbe029       varchar2(1)      ,/* no use */
stbe030       varchar2(1)      ,/* no use */
stbe031       number(20,6)      ,/* 結算扣率 */
stbe032       varchar2(255)      ,/* 備註 */
stbe033       varchar2(40)      ,/* 日結成本類型 */
stbe034       number(20,6)      ,/* 銷售金額 */
stbe035       varchar2(10)      ,/* 費用歸屬類型 */
stbe036       varchar2(10)      ,/* 費用歸屬組織 */
stbe037       number(20,6)      ,/* 應收結算金額 */
stbe038       number(20,6)      ,/* 帳套二應收結算金額 */
stbe039       number(20,6)      ,/* 帳套三應收結算金額 */
stbe040       varchar2(1)      /* 收入立帳否 */
);
alter table stbe_t add constraint stbe_pk primary key (stbeent,stbedocno,stbeseq) enable validate;

create unique index stbe_pk on stbe_t (stbeent,stbedocno,stbeseq);

grant select on stbe_t to tiptop;
grant update on stbe_t to tiptop;
grant delete on stbe_t to tiptop;
grant insert on stbe_t to tiptop;

exit;
