/* 
================================================================================
檔案代號:nmci_t
檔案名稱:應付票據異動明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmci_t
(
nmcient       number(5)      ,/* 企業編碼 */
nmcicomp       varchar2(10)      ,/* 法人 */
nmcidocno       varchar2(20)      ,/* 單據號碼 */
nmciseq       number(10,0)      ,/* 項次 */
nmci001       varchar2(20)      ,/* 票據單號 */
nmci002       varchar2(10)      ,/* 票況 */
nmci003       varchar2(20)      ,/* 開票單號 */
nmci008       varchar2(20)      ,/* 重立帳單號 */
nmci100       varchar2(10)      ,/* 幣別 */
nmci101       number(20,10)      ,/* 匯率 */
nmci103       number(20,6)      ,/* 異動原幣 */
nmci105       number(20,6)      ,/* 利息支出原幣 */
nmci113       number(20,6)      ,/* 異動本幣 */
nmci115       number(20,6)      ,/* 利息支出本幣 */
nmci118       number(20,6)      ,/* 匯差金額 */
nmci121       number(20,10)      ,/* 本位幣二匯率 */
nmci131       number(20,10)      ,/* 本位幣三匯率 */
nmciud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmciud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmciud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmciud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmciud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmciud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmciud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmciud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmciud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmciud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmciud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmciud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmciud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmciud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmciud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmciud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmciud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmciud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmciud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmciud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmciud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmciud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmciud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmciud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmciud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmciud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmciud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmciud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmciud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmciud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmciorga       varchar2(10)      ,/* 來源組織 */
nmci132       varchar2(10)      ,/* 來源類型 */
nmci133       number(10,0)      ,/* 項次 */
nmci009       varchar2(1)      /* 含保證金帳戶否 */
);
alter table nmci_t add constraint nmci_pk primary key (nmcient,nmcicomp,nmcidocno,nmciseq) enable validate;

create unique index nmci_pk on nmci_t (nmcient,nmcicomp,nmcidocno,nmciseq);

grant select on nmci_t to tiptop;
grant update on nmci_t to tiptop;
grant delete on nmci_t to tiptop;
grant insert on nmci_t to tiptop;

exit;
