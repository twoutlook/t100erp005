/* 
================================================================================
檔案代號:stbc_t
檔案名稱:結算底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stbc_t
(
stbcent       number(5)      ,/* 企業編號 */
stbcsite       varchar2(10)      ,/* 營運據點 */
stbc001       varchar2(10)      ,/* 結算中心 */
stbc002       date      ,/* 單據日期 */
stbc003       varchar2(10)      ,/* 單據類別 */
stbc004       varchar2(20)      ,/* 單據編號 */
stbc005       number(10,0)      ,/* 項次 */
stbc006       number(10,0)      ,/* 業務結算期 */
stbc007       number(5,0)      ,/* 財務會計年度 */
stbc008       varchar2(10)      ,/* 對象編號 */
stbc009       varchar2(10)      ,/* 經營方式 */
stbc010       varchar2(10)      ,/* 結算方式 */
stbc011       varchar2(10)      ,/* 結算類型 */
stbc012       varchar2(10)      ,/* 費用編號 */
stbc013       varchar2(4)      ,/* 幣別 */
stbc014       varchar2(10)      ,/* 稅別 */
stbc015       varchar2(10)      ,/* 價款類別 */
stbc016       number(5,0)      ,/* 方向 */
stbc017       number(20,6)      ,/* 價外金額 */
stbc018       number(20,6)      ,/* 價內金額 */
stbc019       number(20,6)      ,/* 未結算金額 */
stbc020       number(20,6)      ,/* 已結算金額 */
stbc021       number(20,6)      ,/* 未校驗金額 */
stbc022       number(20,6)      ,/* 已校驗金額 */
stbc023       number(20,6)      ,/* 未立帳金額 */
stbc024       number(20,6)      ,/* 已立帳金額 */
stbc025       varchar2(10)      ,/* 所屬品類 */
stbc026       varchar2(10)      ,/* 所屬部門 */
stbc027       varchar2(10)      ,/* 對象類別 */
stbc028       number(5,0)      ,/* 財務會計期別 */
stbc029       varchar2(10)      ,/* 網點編號 */
stbc030       varchar2(20)      ,/* 結算合約編號 */
stbc031       varchar2(10)      ,/* 承擔對象 */
stbc032       varchar2(10)      ,/* 結算對象 */
stbcstus       varchar2(10)      ,/* 狀態碼 */
stbc033       varchar2(20)      ,/* 专柜编号 */
stbc034       number(20,6)      ,/* 數量 */
stbc035       number(20,6)      ,/* 已立帳數量 */
stbc036       number(20,6)      ,/* 單價 */
stbc037       varchar2(1)      ,/* 納入結算單否 */
stbc038       varchar2(1)      ,/* 票扣否 */
stbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stbc039       number(20,6)      ,/* 結算扣率 */
stbc040       date      ,/* 結算日期 */
stbc041       varchar2(10)      ,/* 日結成本類型 */
stbc042       number(20,6)      ,/* 銷售金額 */
stbc043       varchar2(40)      ,/* 商品編號 */
stbc044       varchar2(10)      ,/* 商品品類 */
stbc045       date      ,/* 開始日期 */
stbc046       date      ,/* 結束日期 */
stbc047       number(20,6)      ,/* 已立帳金額帳套二 */
stbc048       number(20,6)      ,/* 已立帳金額帳套三 */
stbc049       number(20,6)      ,/* 主帳套暫估金額 */
stbc050       number(20,6)      ,/* 帳套二暫估金額 */
stbc051       number(20,6)      ,/* 帳套三暫估金額 */
stbc052       number(20,6)      ,/* 已立帳數量帳套二 */
stbc053       number(20,6)      ,/* 已立帳數量帳套三 */
stbc054       number(20,6)      ,/* 主帳套暫估數量 */
stbc055       number(20,6)      ,/* 帳套二暫估數量 */
stbc056       number(20,6)      ,/* 帳套三暫估數量 */
stbc057       number(20,6)      ,/* 已結算數量 */
stbc058       varchar2(1)      ,/* 含發票否 */
stbc059       varchar2(10)      ,/* 費用歸屬類型 */
stbc060       varchar2(10)      ,/* 費用歸屬組織 */
stbc061       number(20,6)      ,/* 應收結算金額 */
stbc062       number(20,6)      ,/* 帳套二應收結算金額 */
stbc063       number(20,6)      ,/* 帳套三應收結算金額 */
stbc064       varchar2(1)      /* 收入立帳否 */
);
alter table stbc_t add constraint stbc_pk primary key (stbcent,stbc001,stbc004,stbc005) enable validate;

create unique index stbc_pk on stbc_t (stbcent,stbc001,stbc004,stbc005);

grant select on stbc_t to tiptop;
grant update on stbc_t to tiptop;
grant delete on stbc_t to tiptop;
grant insert on stbc_t to tiptop;

exit;
