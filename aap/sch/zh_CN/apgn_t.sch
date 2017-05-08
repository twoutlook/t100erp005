/* 
================================================================================
檔案代號:apgn_t
檔案名稱:外購信用狀結案檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table apgn_t
(
apgnent       number(5)      ,/* 企業編號 */
apgnownid       varchar2(20)      ,/* 資料所有者 */
apgnowndp       varchar2(10)      ,/* 資料所屬部門 */
apgncrtid       varchar2(20)      ,/* 資料建立者 */
apgncrtdp       varchar2(10)      ,/* 資料建立部門 */
apgncrtdt       timestamp(0)      ,/* 資料創建日 */
apgnmodid       varchar2(20)      ,/* 資料修改者 */
apgnmoddt       timestamp(0)      ,/* 最近修改日 */
apgncnfid       varchar2(20)      ,/* 資料確認者 */
apgncnfdt       timestamp(0)      ,/* 資料確認日 */
apgnstus       varchar2(10)      ,/* 狀態碼 */
apgncomp       varchar2(10)      ,/* 法人 */
apgndocno       varchar2(20)      ,/* 結案單號 */
apgndocdt       date      ,/* 結案日期 */
apgn001       varchar2(20)      ,/* 結案人員 */
apgn002       varchar2(20)      ,/* 退款沖銷單號 */
apgn003       varchar2(20)      ,/* 結案應付憑單號 */
apgn004       number(20,6)      ,/* 預付轉費用金額 */
apgn005       varchar2(10)      ,/* 費用編號 */
apgn100       varchar2(10)      ,/* 幣別 */
apgn101       number(20,10)      ,/* 結案匯率 */
apgn103       number(20,6)      ,/* 開狀金額 */
apgn104       number(20,6)      ,/* 到單金額 */
apgn105       number(20,6)      ,/* 到貨金額 */
apgn106       number(20,6)      ,/* 融資到帳金額 */
apgn107       number(20,6)      ,/* 已付自備款金額 */
apgn108       number(20,6)      ,/* 退還自備款金額 */
apgn109       number(20,6)      ,/* 退還保證金金額 */
apgnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgnud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apgn006       varchar2(10)      ,/* 退還自備款存提碼 */
apgn007       varchar2(10)      ,/* 退還自備款現金變動碼 */
apgn008       varchar2(10)      ,/* 退還保證金存提碼 */
apgn009       varchar2(10)      ,/* 退還保證金現金變動碼 */
apgn010       varchar2(10)      ,/* 退還預付款存提碼 */
apgn011       varchar2(10)      ,/* 退還預付款現金變動碼 */
apgn102       number(20,6)      ,/* 退還預付款原幣金額 */
apgn112       number(20,6)      ,/* 退還預付款本幣金額 */
apgn118       number(20,6)      ,/* 退還自備款本幣金額 */
apgn119       number(20,6)      ,/* 退還保證金本幣金額 */
apgn012       varchar2(10)      ,/* 受款帳戶 */
apgn013       varchar2(20)      /* 申請單號 */
);
alter table apgn_t add constraint apgn_pk primary key (apgnent,apgncomp,apgndocno) enable validate;

create unique index apgn_pk on apgn_t (apgnent,apgncomp,apgndocno);

grant select on apgn_t to tiptop;
grant update on apgn_t to tiptop;
grant delete on apgn_t to tiptop;
grant insert on apgn_t to tiptop;

exit;
