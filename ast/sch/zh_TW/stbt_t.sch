/* 
================================================================================
檔案代號:stbt_t
檔案名稱:結算單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stbt_t
(
stbtent       number(5)      ,/* 企業編號 */
stbtunit       varchar2(10)      ,/* 應用組織 */
stbtsite       varchar2(10)      ,/* 營運據點 */
stbtdocno       varchar2(20)      ,/* 單據編號 */
stbtdocdt       date      ,/* 單據日期 */
stbt001       varchar2(20)      ,/* 合同編號 */
stbt002       varchar2(10)      ,/* 經銷商 */
stbt003       varchar2(10)      ,/* 經營方式 */
stbt004       varchar2(10)      ,/* 結算方式 */
stbt005       varchar2(10)      ,/* 結算類型 */
stbt006       number(10,0)      ,/* 結算會計期 */
stbt007       number(5,0)      ,/* 結算賬期 */
stbt008       date      ,/* 起始日期 */
stbt009       date      ,/* 截止日期 */
stbt010       number(20,6)      ,/* 上期結存金額 */
stbt011       number(20,6)      ,/* 本期銷貨成本 */
stbt012       number(20,6)      ,/* 本期進貨金額 */
stbt013       number(20,6)      ,/* 本期退貨金額 */
stbt014       number(20,6)      ,/* 本期折讓金額 */
stbt015       number(20,6)      ,/* 稅額 */
stbt016       number(20,6)      ,/* 價稅合計 */
stbt017       number(20,6)      ,/* 本期預付金額 */
stbt018       number(20,6)      ,/* 本期價外扣款 */
stbt019       varchar2(1)      ,/* 貨款扣費用否 */
stbt020       number(20,6)      ,/* 應結算金額 */
stbt021       number(20,6)      ,/* 實際結算金額 */
stbt022       number(20,6)      ,/* 本期結存金額 */
stbt023       varchar2(10)      ,/* 結算標識 */
stbt024       varchar2(20)      ,/* 結算人員 */
stbt025       varchar2(10)      ,/* 結算部門 */
stbt026       varchar2(10)      ,/* 結算地點 */
stbt027       varchar2(20)      ,/* 納稅編號 */
stbt028       varchar2(15)      ,/* 銀行編號 */
stbt029       varchar2(30)      ,/* 銀行賬號 */
stbtstus       varchar2(10)      ,/* 狀態碼 */
stbtownid       varchar2(20)      ,/* 資料所有者 */
stbtowndp       varchar2(10)      ,/* 資料所屬部門 */
stbtcrtid       varchar2(20)      ,/* 資料建立者 */
stbtcrtdp       varchar2(10)      ,/* 資料建立部門 */
stbtcrtdt       timestamp(0)      ,/* 資料創建日 */
stbtmodid       varchar2(20)      ,/* 資料修改者 */
stbtmoddt       timestamp(0)      ,/* 最近修改日 */
stbtcnfid       varchar2(20)      ,/* 資料確認者 */
stbtcnfdt       timestamp(0)      ,/* 資料確認日 */
stbtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbtud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stbt_t add constraint stbt_pk primary key (stbtent,stbtdocno) enable validate;

create unique index stbt_pk on stbt_t (stbtent,stbtdocno);

grant select on stbt_t to tiptop;
grant update on stbt_t to tiptop;
grant delete on stbt_t to tiptop;
grant insert on stbt_t to tiptop;

exit;
