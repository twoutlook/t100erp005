/* 
================================================================================
檔案代號:fabh_t
檔案名稱:資產異動單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabh_t
(
fabhent       number(5)      ,/* 企業編號 */
fabhld       varchar2(5)      ,/* 帳套 */
fabhsite       varchar2(10)      ,/* 營運據點 */
fabhdocno       varchar2(20)      ,/* 異動單號 */
fabhseq       number(10,0)      ,/* 項次 */
fabh000       varchar2(10)      ,/* 卡片編號 */
fabh001       varchar2(20)      ,/* 財產編號 */
fabh002       varchar2(20)      ,/* 附號 */
fabh003       number(10)      ,/* 資產狀態 */
fabh004       number(20,6)      ,/* 未折減餘額 */
fabh005       varchar2(10)      ,/* 單位 */
fabh006       number(10,0)      ,/* 數量 */
fabh007       number(10,0)      ,/* 處置數量 */
fabh008       number(20,6)      ,/* 成本 */
fabh009       number(20,6)      ,/* 累計調整成本 */
fabh010       number(20,6)      ,/* 調整成本/公允價值 */
fabh011       number(20,6)      ,/* 累折 */
fabh012       number(20,6)      ,/* 重估累計折舊 */
fabh013       number(10,0)      ,/* 未用年限 */
fabh014       number(10,0)      ,/* 重估未用年限 */
fabh015       number(20,6)      ,/* 預留殘值 */
fabh016       number(20,6)      ,/* 重估預留殘值 */
fabh017       number(20,6)      ,/* 已計提減值準備 */
fabh018       number(10)      ,/* 異動 */
fabh019       number(20,6)      ,/* 減值準備金額 */
fabh020       varchar2(10)      ,/* 異動原因 */
fabh021       varchar2(24)      ,/* 異動科目 */
fabh022       varchar2(24)      ,/* 調整成本 */
fabh023       varchar2(24)      ,/* 累計折舊科目 */
fabh024       varchar2(24)      ,/* 資產科目 */
fabh025       varchar2(24)      ,/* 減值準備科目 */
fabh026       varchar2(10)      ,/* 營運據點 */
fabh027       varchar2(10)      ,/* 部門 */
fabh028       varchar2(10)      ,/* 利潤/成本中心 */
fabh029       varchar2(10)      ,/* 區域 */
fabh030       varchar2(10)      ,/* 交易客商 */
fabh031       varchar2(10)      ,/* 帳款客商 */
fabh032       varchar2(10)      ,/* 客群 */
fabh033       varchar2(20)      ,/* 人員 */
fabh034       varchar2(20)      ,/* 專案編號 */
fabh035       varchar2(30)      ,/* WBS */
fabh036       varchar2(40)      ,/* 摘要 */
fabh037       varchar2(20)      ,/* 來源編號 */
fabh038       number(10,0)      ,/* 來源項次 */
fabh039       varchar2(10)      ,/* 盤點編號 */
fabh040       number(10,0)      ,/* 盤點序號 */
fabh041       varchar2(10)      ,/* 經營方式 */
fabh042       varchar2(10)      ,/* 渠道 */
fabh043       varchar2(10)      ,/* 品牌 */
fabh060       varchar2(10)      ,/* 自由核算項一 */
fabh061       varchar2(10)      ,/* 自由核算項二 */
fabh062       varchar2(10)      ,/* 自由核算項三 */
fabh063       varchar2(10)      ,/* 自由核算項四 */
fabh064       varchar2(10)      ,/* 自由核算項五 */
fabh065       varchar2(10)      ,/* 自由核算項六 */
fabh066       varchar2(10)      ,/* 自由核算項七 */
fabh067       varchar2(10)      ,/* 自由核算項八 */
fabh068       varchar2(10)      ,/* 自由核算項九 */
fabh069       varchar2(10)      ,/* 自由核算項十 */
fabh100       varchar2(10)      ,/* 本位幣二幣別 */
fabh101       number(20,10)      ,/* 本位幣二匯率 */
fabh102       number(20,6)      ,/* 本位幣二成本 */
fabh103       number(20,6)      ,/* 本位幣二調整成本 */
fabh104       number(20,6)      ,/* 本位幣二累折 */
fabh105       number(20,6)      ,/* 本位幣二重估累折 */
fabh106       number(20,6)      ,/* 本位幣二預留殘值 */
fabh107       number(20,6)      ,/* 本位幣二重估殘值 */
fabh108       number(20,6)      ,/* 本位幣二未折減額 */
fabh109       number(20,6)      ,/* 本位幣二已計提減值準備 */
fabh110       number(20,6)      ,/* 本位幣二減值準備金額 */
fabh150       varchar2(10)      ,/* 本位幣三幣別 */
fabh151       number(20,10)      ,/* 本位幣三匯率 */
fabh152       number(20,6)      ,/* 本位幣三成本 */
fabh153       number(20,6)      ,/* 本位幣三調整成本 */
fabh154       number(20,6)      ,/* 本位幣三累折 */
fabh155       number(20,6)      ,/* 本位幣三重估累折 */
fabh156       number(20,6)      ,/* 本位幣三預留殘值 */
fabh157       number(20,6)      ,/* 本位幣三重估殘值 */
fabh158       number(20,6)      ,/* 本位幣三未折減額 */
fabh159       number(20,6)      ,/* 本位幣三已計提減值準備 */
fabh160       number(20,6)      ,/* 本位幣三減值準備金額 */
fabhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabhud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fabh070       varchar2(24)      ,/* 累計折舊科目(舊) */
fabh071       varchar2(24)      ,/* 資產科目(舊) */
fabh072       varchar2(24)      /* 減值準備科目(舊) */
);
alter table fabh_t add constraint fabh_pk primary key (fabhent,fabhld,fabhdocno,fabhseq) enable validate;

create unique index fabh_pk on fabh_t (fabhent,fabhld,fabhdocno,fabhseq);

grant select on fabh_t to tiptop;
grant update on fabh_t to tiptop;
grant delete on fabh_t to tiptop;
grant insert on fabh_t to tiptop;

exit;
