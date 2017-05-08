/* 
================================================================================
檔案代號:apgk_t
檔案名稱:外購到單主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apgk_t
(
apgkent       number(5)      ,/* 企業編號 */
apgkownid       varchar2(20)      ,/* 資料所有者 */
apgkowndp       varchar2(10)      ,/* 資料所屬部門 */
apgkcrtid       varchar2(20)      ,/* 資料建立者 */
apgkcrtdp       varchar2(10)      ,/* 資料建立部門 */
apgkcrtdt       timestamp(0)      ,/* 資料創建日 */
apgkmodid       varchar2(20)      ,/* 資料修改者 */
apgkmoddt       timestamp(0)      ,/* 最近修改日 */
apgkcnfid       varchar2(20)      ,/* 資料確認者 */
apgkcnfdt       timestamp(0)      ,/* 資料確認日 */
apgkpstid       varchar2(20)      ,/* 資料過帳者 */
apgkpstdt       timestamp(0)      ,/* 資料過帳日 */
apgkstus       varchar2(10)      ,/* 狀態碼 */
apgkcomp       varchar2(10)      ,/* 法人 */
apgkdocno       varchar2(20)      ,/* 到單單號 */
apgkdocdt       date      ,/* 到單日期 */
apgk001       varchar2(10)      ,/* 供應商編號 */
apgk002       varchar2(10)      ,/* 付款類型 */
apgk003       varchar2(20)      ,/* L/C NO */
apgk004       varchar2(20)      ,/* 業務人員 */
apgk005       varchar2(20)      ,/* 申請單號 */
apgk006       date      ,/* 押匯日期 */
apgk007       number(5,0)      ,/* 融資天數 */
apgk008       date      ,/* 融資應還款日期 */
apgk009       varchar2(20)      ,/* 融資合約編號 */
apgk010       varchar2(20)      ,/* 融資到帳單號 */
apgk011       date      ,/* 自備款應付到期日 */
apgk012       varchar2(20)      ,/* 應付待抵單號 */
apgk013       varchar2(20)      ,/* 裝運單號 */
apgk014       varchar2(20)      ,/* 到貨單號 */
apgk015       varchar2(20)      ,/* 到單核銷 */
apgk100       varchar2(10)      ,/* 幣別 */
apgk101       number(20,10)      ,/* 還款匯率 */
apgk103       number(20,6)      ,/* 押匯原幣金額 */
apgk113       number(20,6)      ,/* 押匯本幣金額 */
apgk114       number(20,6)      ,/* 應攤還自備款本幣 */
apgkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgkud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apgk104       number(20,6)      ,/* 應攤還自備款原幣金額 */
apgk016       varchar2(10)      ,/* 支付帳戶 */
apgk017       varchar2(10)      ,/* 存提碼 */
apgk018       varchar2(10)      ,/* 現金變動碼 */
apgk019       varchar2(20)      /* 融資還款單號 */
);
alter table apgk_t add constraint apgk_pk primary key (apgkent,apgkcomp,apgkdocno) enable validate;

create unique index apgk_pk on apgk_t (apgkent,apgkcomp,apgkdocno);

grant select on apgk_t to tiptop;
grant update on apgk_t to tiptop;
grant delete on apgk_t to tiptop;
grant insert on apgk_t to tiptop;

exit;
