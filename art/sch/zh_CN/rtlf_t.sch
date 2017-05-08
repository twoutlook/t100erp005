/* 
================================================================================
檔案代號:rtlf_t
檔案名稱:繳款明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtlf_t
(
rtlfent       number(5)      ,/* 企業編號 */
rtlfsite       varchar2(10)      ,/* 營運據點 */
rtlfunit       varchar2(10)      ,/* 應用組織 */
rtlfdocno       varchar2(20)      ,/* 收銀繳款單單號 */
rtlfseq       number(10,0)      ,/* 項次 */
rtlfseq1       number(10,0)      ,/* 收款序 */
rtlf001       varchar2(10)      ,/* 款別類型 */
rtlf002       varchar2(10)      ,/* 款別編號 */
rtlf003       number(20,6)      ,/* 收款金額 */
rtlf004       number(20,6)      ,/* 入帳金額 */
rtlf005       varchar2(40)      ,/* 刷卡機號 */
rtlf006       number(20,6)      ,/* 刷卡手續費率 */
rtlf007       number(20,6)      ,/* 刷卡手續金額 */
rtlf008       number(20,6)      ,/* 支票面額 */
rtlf009       date      ,/* 票據到期日 */
rtlf010       varchar2(15)      ,/* 票據付款銀行 */
rtlf013       varchar2(10)      ,/* 卡/券種編號 */
rtlf014       varchar2(30)      ,/* 會員卡號 */
rtlf015       varchar2(10)      ,/* 券面額編號 */
rtlf016       varchar2(30)      ,/* 起始券號 */
rtlf017       varchar2(30)      ,/* 結束券號 */
rtlf018       number(20,6)      ,/* 券數量 */
rtlf020       number(20,6)      ,/* 票券溢收金額 */
rtlf021       varchar2(10)      ,/* 沖預收款類型 */
rtlf022       number(15,3)      ,/*   */
rtlf024       varchar2(10)      ,/* 退款類型 */
rtlf025       date      ,/* 收款日期 */
rtlf026       varchar2(8)      ,/* 收款時間 */
rtlf032       timestamp(0)      ,/* 自定義欄位(日期時間)032 */
rtlfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtlfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtlfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtlfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtlfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtlfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtlfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtlfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtlfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtlfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtlfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtlfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtlfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtlfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtlfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtlfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtlfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtlfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtlfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtlfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtlfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtlfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtlfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtlfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtlfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtlfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtlfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtlfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtlfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtlfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtlf036       varchar2(40)      ,/* 卡號/票號/帳號/待抵單號 */
rtlf037       varchar2(1)      ,/* 是否已入帳 */
rtlf103       varchar2(20)      /* 來源單號 */
);
alter table rtlf_t add constraint rtlf_pk primary key (rtlfent,rtlfdocno,rtlfseq) enable validate;

create unique index rtlf_pk on rtlf_t (rtlfent,rtlfdocno,rtlfseq);

grant select on rtlf_t to tiptop;
grant update on rtlf_t to tiptop;
grant delete on rtlf_t to tiptop;
grant insert on rtlf_t to tiptop;

exit;
