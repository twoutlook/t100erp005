/* 
================================================================================
檔案代號:stba_t
檔案名稱:費用單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stba_t
(
stbaent       number(5)      ,/* 企業編號 */
stbasite       varchar2(10)      ,/* 營運據點 */
stbaunit       varchar2(10)      ,/* 應用組織 */
stbadocno       varchar2(20)      ,/* 單據編號 */
stbadocdt       date      ,/* 單據日期 */
stba001       varchar2(10)      ,/* 結算中心 */
stba002       varchar2(10)      ,/* 供應商編號 */
stba003       varchar2(10)      ,/* 經營方式 */
stba004       varchar2(10)      ,/* 結算方式 */
stba005       varchar2(10)      ,/* 結算類型 */
stba006       varchar2(10)      ,/* 來源類型 */
stba007       varchar2(20)      ,/* 來源單號 */
stba008       varchar2(20)      ,/* 人員 */
stba009       varchar2(10)      ,/* 部門 */
stbastus       varchar2(10)      ,/* 狀態碼 */
stbaownid       varchar2(20)      ,/* 資料所屬者 */
stbaowndp       varchar2(10)      ,/* 資料所有部門 */
stbacrtid       varchar2(20)      ,/* 資料建立者 */
stbacrtdp       varchar2(10)      ,/* 資料建立部門 */
stbacrtdt       timestamp(0)      ,/* 資料創建日 */
stbamodid       varchar2(20)      ,/* 資料修改者 */
stbamoddt       timestamp(0)      ,/* 最近修改日 */
stbacnfid       varchar2(20)      ,/* 資料確認者 */
stbacnfdt       timestamp(0)      ,/* 資料確認日 */
stbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stba010       varchar2(20)      ,/* 合約編號 */
stba011       varchar2(10)      ,/* 幣別 */
stba012       varchar2(10)      ,/* 稅別 */
stba013       varchar2(20)      ,/* 專櫃編號/鋪位編號 */
stba014       varchar2(10)      ,/* 費用類型 */
stba015       varchar2(1)      ,/* 交款狀態 */
stba000       varchar2(20)      ,/* 程式編號 */
stba016       varchar2(80)      ,/* 交款人 */
stba017       number(10,0)      ,/* 結算帳期 */
stba018       date      ,/* 結算日期 */
stba019       date      ,/* 開始日期 */
stba020       date      ,/* 結束日期 */
stba021       number(20,6)      ,/* 成本總額 */
stba022       varchar2(10)      ,/* 法人 */
stba023       number(20,6)      ,/* 會員折扣金額 */
stba024       varchar2(20)      ,/* no_use */
stba025       number(10,0)      ,/* 合約帳期 */
stba026       date      ,/* 計算日期 */
stba027       number(10,0)      /* 来源单号項次 */
);
alter table stba_t add constraint stba_pk primary key (stbaent,stbadocno) enable validate;

create unique index stba_pk on stba_t (stbaent,stbadocno);

grant select on stba_t to tiptop;
grant update on stba_t to tiptop;
grant delete on stba_t to tiptop;
grant insert on stba_t to tiptop;

exit;
