/* 
================================================================================
檔案代號:xrgf_t
檔案名稱:銷售信用狀主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xrgf_t
(
xrgfent       number(5)      ,/* 企業編碼 */
xrgfcomp       varchar2(10)      ,/* 法人 */
xrgfdocno       varchar2(20)      ,/* 押匯單號 */
xrgfdocdt       date      ,/* 押匯日期 */
xrgf001       number(10,0)      ,/* 押匯次數 */
xrgf002       varchar2(20)      ,/* 業務人員 */
xrgf003       varchar2(10)      ,/* 客戶編號 */
xrgf004       varchar2(15)      ,/* 押匯銀行 */
xrgf005       varchar2(20)      ,/* inovice 單號 */
xrgf006       varchar2(1)      ,/* 押匯文件 */
xrgf007       varchar2(255)      ,/* 備註 */
xrgf008       date      ,/* 匯入日期 */
xrgf009       varchar2(20)      ,/* 收狀單號 */
xrgf010       varchar2(20)      ,/* 帳務單號 */
xrgf100       varchar2(10)      ,/* 幣別 */
xrgf101       number(20,10)      ,/* 押匯匯率 */
xrgf103       number(20,6)      ,/* 押匯原幣金額 */
xrgf104       number(20,6)      ,/* invoice 原幣金額 */
xrgf113       number(20,6)      ,/* 押匯本幣金額 */
xrgfstus       varchar2(1)      ,/* 狀態碼 */
xrgfownid       varchar2(20)      ,/* 資料所有者 */
xrgfowndp       varchar2(10)      ,/* 資料所屬部門 */
xrgfcrtid       varchar2(20)      ,/* 資料建立者 */
xrgfcrtdp       varchar2(10)      ,/* 資料建立部門 */
xrgfcrtdt       timestamp(0)      ,/* 資料創建日 */
xrgfmodid       varchar2(20)      ,/* 資料修改者 */
xrgfmoddt       timestamp(0)      ,/* 最近修改日 */
xrgfcnfid       varchar2(20)      ,/* 資料確認者 */
xrgfcnfdt       timestamp(0)      ,/* 資料確認日 */
xrgfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrgfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrgfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrgfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrgfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrgfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrgfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrgfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrgfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrgfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrgfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrgfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrgfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrgfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrgfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrgfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrgfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrgfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrgfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrgfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrgfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrgfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrgfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrgfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrgfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrgfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrgfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrgfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrgfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrgfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xrgf011       varchar2(10)      ,/* 交易帳戶 */
xrgf012       varchar2(10)      ,/* 存提碼 */
xrgf013       varchar2(10)      /* 現金變動碼 */
);
alter table xrgf_t add constraint xrgf_pk primary key (xrgfent,xrgfcomp,xrgfdocno,xrgf001) enable validate;

create unique index xrgf_pk on xrgf_t (xrgfent,xrgfcomp,xrgfdocno,xrgf001);

grant select on xrgf_t to tiptop;
grant update on xrgf_t to tiptop;
grant delete on xrgf_t to tiptop;
grant insert on xrgf_t to tiptop;

exit;
